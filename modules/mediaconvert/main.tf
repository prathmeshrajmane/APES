resource "aws_iam_role" "apes-mediaconvert-lambda-iam" {
  name = var.apes_vod_lambdafunction_role

  assume_role_policy = file("iam-lambda-role.json")
}

resource "aws_iam_role_policy" "mediaconvert" {
  name = var.vod_mediaconvert_iam_policy
  role = aws_iam_role.apes-mediaconvert-lambda-iam.id

  policy = file("mediaconvert.json")
}

data "aws_s3_bucket" "s3_backend" {
  bucket = var.apes_backend_bucket
}
data "aws_s3_bucket" "elemental_archive_input"{
  bucket = var.elemental_archive_input_bucket
}

data "aws_s3_bucket" "elemental_vod_input"{
  bucket = var.elemental_vod_input_bucket
}

data "aws_s3_bucket" "elemental_output"{
  bucket = var.elemental_output_bucket
}

resource "aws_lambda_function" "apes_archive_lambda" {
  function_name    = var.apes_archive_lambdafunction
  role             = aws_iam_role.apes-mediaconvert-lambda-iam.arn
  handler          = "${var.apes_archive_lambdafunction}.${var.apes_lambdahandler_name}"
  runtime          = var.apes_lambdaruntime
  timeout          = var.apes_lambdatimeout
  s3_bucket = data.aws_s3_bucket.s3_backend.id
  s3_key = "lambda/archive-mediaconvert/archive.zip"
  #source_code_hash = "${data.aws_s3_bucket_object.code_zip.body}"
  environment {
    variables = {
      DestinationBucket = var.elemental_output_bucket
      MediaConvertRole  = aws_iam_role.apes-mediaconvert-lambda-iam.arn
    }
  }
  tags = merge(
    var.tags,
    tomap({ "Name" = var.apes_archive_lambdafunction })
  )
}

resource "aws_s3_bucket_notification" "apes-archive-lambda-trigger" {
  bucket                = data.aws_s3_bucket.elemental_archive_input.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.apes_archive_lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "latest/"
  }
  depends_on = [
    aws_lambda_permission.apes-archive-s3invoke
  ]
}

resource "aws_lambda_permission" "apes-archive-s3invoke" {
  statement_id  = "AllowS3-Invoke-archive"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.apes_archive_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = data.aws_s3_bucket.elemental_archive_input.arn
}


resource "aws_lambda_function" "apes_vod_lambda" {
  function_name    = var.apes_vod_lambdafunction
  role             = aws_iam_role.apes-mediaconvert-lambda-iam.arn
  handler          = "${var.apes_vod_lambdafunction}.${var.apes_lambdahandler_name}"
  runtime          = var.apes_lambdaruntime
  timeout          = var.apes_lambdatimeout
  s3_bucket = data.aws_s3_bucket.s3_backend.id
  s3_key = "lambda/vod-mediaconvert/mediaconvert.zip"
  environment {
    variables = {
      DestinationBucket = var.elemental_output_bucket
      MediaConvertRole  = aws_iam_role.apes-mediaconvert-lambda-iam.arn
    }
  }
  tags = merge(
    var.tags,
    tomap({ "Name" = var.apes_vod_lambdafunction })
  )
}


resource "aws_s3_bucket_notification" "apes-vod-lambda-trigger" {
  bucket                = data.aws_s3_bucket.elemental_vod_input.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.apes_vod_lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "vod/"
  }
  depends_on = [
    aws_lambda_permission.apes-vod-s3invoke
  ]
}


resource "aws_lambda_permission" "apes-vod-s3invoke" {
  statement_id  = "AllowS3-Invoke-vod"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.apes_vod_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = data.aws_s3_bucket.elemental_vod_input.arn
}

# resource "null_resource" "update-lambda" {
#   provisioner "local-exec" {
#     command = "aws lambda update-function-code --function-name ${var.apes_archive_lambdafunction} --zip-file fileb://../../lambda/archive-mediaconvert/archive.zip"
#   }
#   depends_on = [
#     aws_lambda_function.apes_archive_lambda
#   ]
# }
