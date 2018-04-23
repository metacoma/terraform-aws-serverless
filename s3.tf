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

data "archive_file" "invite_zip" {
  type        = "zip"
  source_file = "js/invite.js"
  output_path = "${var.js_zip_path}"
}

resource "aws_s3_bucket_object" "invite" {
  bucket = "${aws_s3_bucket.courses2.id}"
  key    = "${var.s3_js_key}"
  source = "${data.archive_file.invite_zip.output_path}"
  etag   = "${data.archive_file.invite_zip.output_md5}"
  depends_on = [ "aws_s3_bucket.courses2" ]
}
