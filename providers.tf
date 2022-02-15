provider "aws" {
  alias = "us-east-1"
  profile = "default"
  region  = "us-east-1"
}

provider "aws" {
  alias = "us-east-2"
  region  = "us-east-2"
}
