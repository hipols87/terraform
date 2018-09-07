#The access key ID.
output "iam_access_key_id_test_user" {
  value = "${aws_iam_access_key.test_user.id}"
}

#The access key ID.
output "iam_access_key_id_prod_user" {
  value = "${aws_iam_access_key.prod_user.id}"
}

output "iam_access_encrypted_secret_test_user" {
  value = "${aws_iam_access_key.test_user.secret}"
}

output "iam_access_encrypted_secret_prod_user" {
  value = "${aws_iam_access_key.prod_user.secret}"
}