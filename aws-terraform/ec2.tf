module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.4.0"

  name = "pythonapp-instance"

  instance_type = "t2.medium"
  ami           = "ami-0685bcc683dadb6b9"
  key_name      = aws_key_pair.ec2_key.key_name
  monitoring    = true
  subnet_id     = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  vpc_security_group_ids = [
    module.vote_service_sg.security_group_id
  ]
  root_block_device = {
      volume_type = "gp3"
      volume_size = 20
    }
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
