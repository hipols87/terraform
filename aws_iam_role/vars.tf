 variable "region" {
      description = "The AWS region to launch"
}

variable "profile" {
     description = "What AWS profile to use for deployment"
     default = "default"
}
variable "bucket_name" {
      description = "Name s3 bucket for save state file"
}

variable "envname" {
      description = "Environment name"
}
variable "s3_state_profile" {
      description = "Profile for credentials s3 backet state file"
      default = "s3_state_profile"
}