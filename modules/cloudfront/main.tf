resource "aws_cloudfront_origin_access_identity" "s3-cf-oai" {}
resource "aws_cloudfront_origin_access_identity" "s3-cf-oai-vod" {}

data "aws_s3_bucket" "elemental_output"{
    bucket = var.elemental_output_bucket
}
data "aws_s3_bucket" "apes-ui" {
  bucket = var.apes_ui_bucket
}

data "aws_iam_policy_document" "cloudfront_oai_policy" {
  statement {
    sid = "1"
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.s3-cf-oai.iam_arn]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${data.aws_s3_bucket.apes-ui.arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "cloudfront_vod_oai_policy" {
  statement {
    sid = "1"
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.s3-cf-oai-vod.iam_arn]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${data.aws_s3_bucket.elemental_output.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "cdn-cf-policy" {
  bucket = data.aws_s3_bucket.apes-ui.id
  policy = data.aws_iam_policy_document.cloudfront_oai_policy.json
}

resource "aws_s3_bucket_policy" "cdn-cf-vod-policy" {
  bucket = data.aws_s3_bucket.elemental_output.id
  policy = data.aws_iam_policy_document.cloudfront_vod_oai_policy.json
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  depends_on = [aws_cloudfront_origin_access_identity.s3-cf-oai]
  comment = "The frontend distribution for APES"
  origin {
    domain_name = data.aws_s3_bucket.apes-ui.bucket_domain_name
    origin_id   = var.apes_s3_origin_id

    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/${aws_cloudfront_origin_access_identity.s3-cf-oai.id}"
    }
  }
  default_root_object = "index.html"
  enabled             = true
  is_ipv6_enabled     = true

  logging_config {
    include_cookies = false
    bucket          = "${var.apes_backend_bucket}.s3.amazonaws.com"
    prefix          = "mediapakage/"
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.apes_s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  ordered_cache_behavior {
    path_pattern     = "/content/immutable/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = var.apes_s3_origin_id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
  tags = var.tags
}


resource "aws_cloudfront_distribution" "s3_distribution_vod" {
  depends_on = [aws_cloudfront_origin_access_identity.s3-cf-oai-vod]
  comment = "VOD/Archive serving distribution"
  origin {
    domain_name = data.aws_s3_bucket.elemental_output.bucket_domain_name
    origin_id   = var.apes_s3_output_origin_id

    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/${aws_cloudfront_origin_access_identity.s3-cf-oai-vod.id}"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  logging_config {
    include_cookies = false
    bucket          = "${var.apes_backend_bucket}.s3.amazonaws.com"
    prefix          = "mediapakage/vod"
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.apes_s3_output_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  ordered_cache_behavior {
    path_pattern     = "/content/immutable/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = var.apes_s3_output_origin_id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
  tags = var.tags
}