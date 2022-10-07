output "media_access_role_name" {
  description = "IAM Role name."
  value       = aws_iam_role.apes_elemental_live.name
}

output "media_access_role_arn" {
  description = "The ARN assigned by AWS for this role."
  value       = aws_iam_role.apes_elemental_live.arn
}
