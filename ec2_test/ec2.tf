provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

terraform {
  backend "s3" {
    bucket  = "tf-remote-state-storage"
    key     = "non-prod/dev-env/terraform.tfstate"
    region  = "${var.region}"
    encrypt = true
  }
}

data "terraform_remote_state" "ec2_test" {
  backend = "s3"
  config {
    encrypt = true
    bucket = "tfstate-dev-env-s3-bucket"
    key    = "ec2_test/terraform.tfstate"
    region = "${var.region}"
    # access_key = "${var.s3bucket_access_key}"
    # secret_key = "${var.s3bucket_secret_key}"
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