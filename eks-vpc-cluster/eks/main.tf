provider "aws" {
  region     = "eu-central-1"
  access_key = "mock_access_key"
  secret_key = "mock_secret_key"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = { path = "../vpc/terraform.tfstate" }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "mlops-eks"
  cluster_version = "1.27"

  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets

  eks_managed_node_groups = {
    cpu_nodes = { instance_types = ["t3.micro"], min_size = 1, max_size = 2 }
    gpu_nodes = { instance_types = ["t3.micro"], labels = { hardware = "gpu" } }
  }
}