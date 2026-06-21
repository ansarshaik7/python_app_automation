module "iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "6.6.1"

  name = "admin_role"

  trust_policy_permissions = {
    TrustEC2Service = {
      actions = [
        "sts:AssumeRole"
      ]
      principals = [
        {
          type = "Service"
          identifiers = [
            "ec2.amazonaws.com"
          ]
        }
      ]
    }
  }

  policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
    AmazonS3FullAccess  = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    AmazonEC2ContainerRegistryPowerUser = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    AmazonEKSClusterPolicy = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

