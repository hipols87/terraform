provider "aws" {
  shared_credentials_file = "/Users/hipols/.aws/credentials"
  region                  = "${var.region}"
  profile                 = "${var.profile}"

}

terraform {
  backend "s3" {}
}

data "terraform_remote_state" "ec2_test" {
  backend = "s3"
  config {
    encrypt                 = true
    bucket                  = "${var.bucket_name}"
    key                     = "state/${var.envname}/terraform.tfstate"
    region                  = "${var.region}"
    shared_credentials_file = "/Users/hipols/.aws/credentials"
    profile                 = "${var.s3_state_profile}"
  }
}

data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS ENA*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["679593333241"]
}

resource "aws_instance" "ec2_test" {
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t2.micro"

  tags {
    Name = "EC2 TEST"
  }
}