terraform {
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()

    arguments = [
      "-var-file=${get_parent_terragrunt_dir()}/dev.tfvars"
    ]
  }

}
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "s3" {
    bucket         = "apes-dev-backend"
    key            = "${path_relative_to_include()}/dev.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "apes-terraform-state-lock-table"
  }
}
EOF
}

