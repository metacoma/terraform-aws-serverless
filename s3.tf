resource "aws_s3_bucket" "courses2" {
  bucket = "courses2"
  acl    = "public-read"

  tags {
    Name        = "courses2"
    Environment = "Dev"
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["POST", "PUT", "GET"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
  force_destroy = true
}

resource "aws_s3_bucket_object" "invite" {
  bucket = "${aws_s3_bucket.courses2.id}"
  key    = "v1.0.0/invite.zip"
  source = "./invite.zip"
  etag   = "${md5(file("./invite.zip"))}"
  depends_on = [ "aws_s3_bucket.courses2" ]
}
