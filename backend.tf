terraform {
  backend "s3" {
    bucket = "devops-raghav-bu"
    key    = "infra/statefile"
    region = "us-east-1"
  }
}
