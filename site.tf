resource "aws_s3_bucket" "courses-site" {
  bucket = "courses-site"
  acl    = "public-read"

  tags {
    Name        = "courses-site"
    Environment = "Dev"
  }
   policy = <<EOF
{
  "Id": "bucket_policy_courses_site",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "bucket_policy_courses_site_main",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.bucket_site}/*",
      "Principal": "*"
    }
  ]
}
EOF
  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  force_destroy = true
}

resource "aws_s3_bucket_object" "index" {
  bucket = "${aws_s3_bucket.courses-site.id}"
  key    = "./index.html"
  source = "html/index.html"
  etag   = "${md5(file("./html/index.html"))}"
  depends_on = [ "aws_s3_bucket.courses-site" ]
  content_type = "text/html; charset=utf-8"
  acl    = "public-read"
}


