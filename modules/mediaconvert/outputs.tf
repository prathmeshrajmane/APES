output "archive_lambda_arn" {
  value = "${aws_lambda_function.apes_archive_lambda.arn}"
}

output "vod_lambda_arn" {
  value = "${aws_lambda_function.apes_vod_lambda.arn}"
}