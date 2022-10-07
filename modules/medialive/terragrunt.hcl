include {
  path = find_in_parent_folders()
}
dependency "mediapackage" {
    config_path = "../mediapackage"
    mock_outputs = {
      media_package_channel_id = "mediapackagechannel"
      
    }
  }

dependency "iam-roles" {
  config_path = "../iam-roles"
  mock_outputs = {
    media_access_role_arn = "mediaaccessrole"
  }
}


dependency "vpc" {
  config_path = "../vpc"
    mock_outputs = {
    vpc_id = "aws_vpc.vpc.id"
  }
}


inputs = {
  mediapackage_channel_id = dependency.mediapackage.outputs.media_package_channel_id
  media_access_role_arn = dependency.iam-roles.outputs.media_access_role_arn
  vpc_id      = dependency.vpc.outputs.vpc_id
  private_subnet_ids = dependency.vpc.outputs.private_subnets_id

}