resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-profile"
  role = module.iam_role.name
}
