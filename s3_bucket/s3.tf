provider "aws" {
  shared_credentials_file = "/Users/hipols/.aws/credentials"
  region                  = "${var.region}"
  profile                 = "${var.profile}"
}

resource "aws_iam_user" "user" {
    name = "${var.bucket_name}"
}

resource "aws_iam_access_key" "user" {
    user = "${aws_iam_user.user.name}"
    pgp_key = "${var.pgp_key}"
}

resource "aws_iam_user_policy" "user_ro" {
    name = "${var.bucket_name}_ro"
    user = "${aws_iam_user.user.name}"
    policy= <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.bucket_name}",
                "arn:aws:s3:::${var.bucket_name}/*"
            ]
        }
   ]
}
EOF
}

resource "aws_s3_bucket" "bucket" {
    bucket = "${var.bucket_name}"
    acl = "public-read"

    tags {
      Name = "${var.tag_name_s3bucket}"
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
            "Resource": "arn:aws:s3:::${var.bucket_name}/*"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_iam_user.user.arn}"
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.bucket_name}",
                "arn:aws:s3:::${var.bucket_name}/*"
            ]
        }
    ]
}
EOF
}