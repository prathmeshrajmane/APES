resource "aws_iam_role" "apes_elemental_live" {
  name = var.apes_medialive_role
  assume_role_policy = file("iam-role.json")
  tags = merge(
    var.tags,
    tomap({ "Name" = var.apes_medialive_role })
  )
}

resource "aws_iam_role_policy" "s3-bucket" {
  name = var.s3_iam_policy
  role = aws_iam_role.apes_elemental_live.id

  policy = file("s3-bucket.json")

}

resource "aws_iam_role_policy" "mediapackage" {
  name = var.mediapackage_iam_policy
  role = aws_iam_role.apes_elemental_live.id

  policy = file("mediapackage.json")

}

resource "aws_iam_role_policy" "medialive" {
  name = var.medialive_iam_policy
  role = aws_iam_role.apes_elemental_live.id

  policy = file("medialive.json")

}
