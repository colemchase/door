
resource "aws_s3_bucket" "face_images" {
  bucket = var.bucket_name
  force_destroy = true
}

output "bucket_name" {
  value = aws_s3_bucket.face_images.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.face_images.arn
}
