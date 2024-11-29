data "aws_availability_zones" "region1" {
  provider = aws.region1
}

data "aws_availability_zones" "region2" {
  provider = aws.region2
}
