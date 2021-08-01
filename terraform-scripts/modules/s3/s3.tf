resource "aws_s3_bucket" "terraform-state" {
  bucket = "nodejs-app-bucket"
  lifecycle {
        prevent_destroy = false
  }
  versioning {
        enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
     }
   }
 }
  tags = {
    Name        = "Sample bucket"
    Environment = "Development"
 }
}
