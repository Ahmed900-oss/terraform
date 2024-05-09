
provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["C:/Users/Ahmed/.aws/credentials"]
}
variable "var-dev-subnet" {
  description = "enter the ip range of subnet-2"
}
variable "var-vpc-name" {
  description = "the vpc name"
  type        = string
}
resource "aws_vpc" "development-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name : var.var-vpc-name
  }
}
variable "zone" {}

resource "aws_subnet" "development-subnet-1" {
  vpc_id            = aws_vpc.development-vpc.id
  cidr_block        = var.var-dev-subnet[0]
  availability_zone = var.zone
  tags = {
    Name : "subnet-1-dev"
  }
}
data "aws_vpc" "existing-vpc" {
  default = true
}


resource "aws_subnet" "development-subnet-2" {
  vpc_id            = data.aws_vpc.existing-vpc.id
  cidr_block        = var.var-dev-subnet[1]
  availability_zone = "us-east-1a"
  tags = {
    Name : "subnet-1-default"
  }

}
