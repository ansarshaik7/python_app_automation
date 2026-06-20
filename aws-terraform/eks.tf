module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"
  name = "python-app-eks"
  kubernetes_version = "1.33"
  endpoint_public_access = true
  authentication_mode = "API_AND_CONFIG_MAP"
  enable_cluster_creator_admin_permissions = true
  addons = {
    coredns = {}
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
    eks-pod-identity-agent = {
      before_compute = true
    }
  }
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  access_entries = {
    jenkins = {
      principal_arn = module.iam_role.arn
      policy_associations = {
        cluster_admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  eks_managed_node_groups = {
    worker_nodes = {
      ami_type = "AL2023_x86_64_STANDARD"
      instance_types = [
        "t3.medium"
      ]
      min_size = 1
      max_size = 1
      desired_size = 1
    }
  }
  tags = {
    Environment = "dev"
    Terraform = "true"
  }
}
