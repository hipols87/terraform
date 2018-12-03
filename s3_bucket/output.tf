output "iam_access_key_id_test_user" {
  value = "${aws_iam_access_key.user.id}"
}

output "iam_access_encrypted_secret_test_user" {
  value = "${aws_iam_access_key.user.secret}"
}
