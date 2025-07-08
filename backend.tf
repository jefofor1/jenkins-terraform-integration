terraform {
  backend "s3" {
    bucket = "jenkins-terraform-state-bucket-2025"
    key = "main"
    region = "us-east-2"
    dynamodb_table = "terraform-state-lock-table"
  }
}
