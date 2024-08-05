resource "aws_iam_role" "demo" {
  name = "eks-cluster-demo"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "demo_amazon_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.demo.name
}

resource "aws_eks_cluster" "demo" {
  name     = var.eks_cluster_name
  version  = var.eks_cluster_version
  role_arn = aws_iam_role.demo.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private_eu_west_1a.id,
      aws_subnet.private_eu_west_1b.id,
      aws_subnet.public_eu_west_1a.id,
      aws_subnet.public_eu_west_1b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.demo_amazon_eks_cluster_policy]
}

data "tls_certificate" "demo" {
 url = aws_eks_cluster.demo.identity.0.oidc.0.issuer
}

resource "aws_iam_openid_connect_provider" eks_oidc_provider {
 client_id_list = ["sts.amazonaws.com"]
 thumbprint_list = [data.tls_certificate.demo.certificates[0].sha1_fingerprint]
 url = aws_eks_cluster.demo.identity.0.oidc.0.issuer
 
}

resource "aws_eks_identity_provider_config" "demo" {
  cluster_name = aws_eks_cluster.demo.name
  oidc {
    client_id = "${substr(aws_eks_cluster.demo.identity.0.oidc.0.issuer, -32, -1)}"
    identity_provider_config_name = "demo"
    issuer_url = "https://${aws_iam_openid_connect_provider.eks_oidc_provider.url}"
  }
}

module "cluster_autoscaler_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.30.1"

  role_name                        = "cluster-autoscaler"
  attach_cluster_autoscaler_policy = true
  cluster_autoscaler_cluster_ids   = [aws_eks_cluster.demo.name]

  oidc_providers = {
    ex = {
      provider_arn               = aws_iam_openid_connect_provider.eks_oidc_provider.arn
      namespace_service_accounts = ["kube-system:cluster-autoscaler"]
    }
  }
}
