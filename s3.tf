resource "aws_s3_bucket" "my-s3-bucket" {
  bucket_prefix = var.bucket_prefix
  
  tags = var.tags
}

resource "aws_s3_bucket_versioning" "my-s3-bucket-versioning" {
  bucket = aws_s3_bucket.my-s3-bucket.id
  versioning_configuration {
    status = var.versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_acl" "my-s3-bucket-acl" {
  bucket = aws_s3_bucket.my-s3-bucket.id
  acl    = var.acl
  
  depends_on = [aws_s3_bucket_ownership_controls.my-s3-bucket-ownership]
}

resource "aws_s3_bucket_ownership_controls" "my-s3-bucket-ownership" {
  bucket = aws_s3_bucket.my-s3-bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
