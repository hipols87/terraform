provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_iam_user" "test_user" {
    name = "${var.test_bucket_name}"
}

resource "aws_iam_access_key" "test_user" {
    user = "${aws_iam_user.test_user.name}"
    pgp_key = "${var.pgp_key}"
}

resource "aws_iam_user_policy" "test_user_ro" {
    name = "test"
    user = "${aws_iam_user.test_user.name}"
    policy= <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.test_bucket_name}",
                "arn:aws:s3:::${var.test_bucket_name}/*"
            ]
        }
   ]
}
EOF
}

resource "aws_iam_user" "prod_user" {
    name = "${var.prod_bucket_name}"
}

resource "aws_iam_access_key" "prod_user" {
    user = "${aws_iam_user.prod_user.name}"
    pgp_key = "${var.pgp_key}"
}

resource "aws_iam_user_policy" "prod_user_ro" {
    name = "prod"
    user = "${aws_iam_user.prod_user.name}"
   policy= <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.prod_bucket_name}",
                "arn:aws:s3:::${var.prod_bucket_name}/*"
            ]
        }
   ]
}
EOF
}

resource "aws_s3_bucket" "prod_bucket" {
    bucket = "${var.prod_bucket_name}"
    acl = "public-read"

    tags {
      Name = "Prod S3 Remote Terraform State Store"
    } 

    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT","POST"]
        allowed_origins = ["*"]
        expose_headers = ["ETag"]
        max_age_seconds = 3000
    }

    policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "PublicReadForGetBucketObjects",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.prod_bucket_name}/*"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_iam_user.prod_user.arn}"
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.prod_bucket_name}",
                "arn:aws:s3:::${var.prod_bucket_name}/*"
            ]
        }
    ]
}
EOF
}

resource "aws_s3_bucket" "test_bucket" {
    bucket = "${var.test_bucket_name}"
    acl = "public-read"

    tags {
      Name = "Test S3 Remote Terraform State Store"
    }

    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT","POST"]
        allowed_origins = ["*"]
        expose_headers = ["ETag"]
        max_age_seconds = 3000
    }

    policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "PublicReadForGetTestBucketObjects",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.test_bucket_name}/*"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_iam_user.test_user.arn}"
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.test_bucket_name}",
                "arn:aws:s3:::${var.test_bucket_name}/*"
            ]
        }
    ]
}
EOF
}