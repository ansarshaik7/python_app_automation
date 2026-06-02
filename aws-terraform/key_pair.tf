resource "aws_key_pair" "ec2_key" {
  key_name   = "ansar-key"
  public_key = file("${path.module}/id_ed25519.pub")
}