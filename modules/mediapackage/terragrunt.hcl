include {
  path = find_in_parent_folders()
}

dependency "iam-roles" {
  config_path = "../iam-roles"
  mock_outputs = {
    media_access_role_arn = "mediaaccessrole"
  }
}

#dependency "s3" {
#  config_path = "../s3"
#  mock_outputs = {
#    apes_s3_bucket_name = "bucket"
#  }
#}
inputs = {

  media_access_role_arn = dependency.iam-roles.outputs.media_access_role_arn
}