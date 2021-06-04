provider "google" {
    credentials = "../account.json"
    project = "terraformdeploynginx"
    region = "us-west-1"
}

provider "aws" {
    region = "us-west-2"
}