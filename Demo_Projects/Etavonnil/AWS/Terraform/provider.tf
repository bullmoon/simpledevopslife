provider "aws" {
  profile = "terraform"
  region  = "${var.AWS_REGION}"
}