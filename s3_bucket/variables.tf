variable "profile" {
     description = "What AWS profile to use for deployment"
     default = "default"
 }
 variable "region" {
      description = "The AWS region to launch"
 }
variable "bucket_name" {}
variable "tag_name_s3bucket" {}

variable "pgp_key" {
  default = ""
}