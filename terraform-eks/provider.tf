terraform {
  required_providers {
    aws = {
      source  = "harshicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = "1.2.0"

}

provider "aws" {
  region = "us-east-1"

}

provider "Kubernetes" {

  host                   = data.aws_eks_cluster.mycluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.mycluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.mycluster.token

}
