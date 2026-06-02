module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "5.14.0"

  bucket = "pythonapp-s3-bucket"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}

resource "aws_s3_object" "java_sh" {
  bucket = module.s3_bucket.s3_bucket_id
  key    = "scripts/java.sh"
  source = "${path.module}/java.sh"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${path.module}/java.sh")
}

resource "aws_s3_object" "jenkins_sh" {
  bucket = module.s3_bucket.s3_bucket_id
  key    = "scripts/jenkins.sh"
  source = "${path.module}/jenkins.sh"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${path.module}/jenkins.sh")
}

resource "aws_s3_object" "Dockerfile" {
  bucket = module.s3_bucket.s3_bucket_id
  key    = "scripts/Dockerfile"
  source = "${path.module}/Dockerfile"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${path.module}/Dockerfile")
}