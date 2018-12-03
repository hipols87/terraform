provider "aws" {
  shared_credentials_file = "/Users/hipols/.aws/credentials"
  region                  = "${var.region}"
  profile                 = "${var.profile}"

}

terraform {
  backend "s3" {}
}

data "terraform_remote_state" "iam_role" {
  backend = "s3"
  config {
    encrypt                 = true
    bucket                  = "${var.bucket_name}"
    key                     = "state/${var.envname}/iam_role/terraform.tfstate"
    region                  = "${var.region}"
    shared_credentials_file = "/Users/hipols/.aws/credentials"
    profile                 = "${var.s3_state_profile}"
  }
}

resource "aws_iam_role" "test_role" {
  name = "test_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}