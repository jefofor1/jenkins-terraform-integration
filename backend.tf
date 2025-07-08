terraform {
  backend "s3" {
    bucket = "your-actual-bucket-name-here"
    key = "main"
    region = "us-east-2"  # Match your region
    dynamodb_table = "your-actual-dynamodb-table-name"
  }
}
