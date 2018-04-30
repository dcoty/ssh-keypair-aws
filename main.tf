terraform {
  required_version = ">= 0.11.6"
}

provider "aws" {
  version = "~> 1.12"
}

provider "random" {
  version = "~> 1.1"
}

provider "tls" {
  version = "~> 1.1"
}

provider "null" {
  version = "~> 1.0"
}

module "tls_private_key" {
  source = "github.com/hashicorp-modules/tls-private-key"

  create    = "${var.create}"
  name      = "${var.name}"
  rsa_bits  = "${var.rsa_bits}"
}

resource "aws_key_pair" "main" {
  count = "${var.create ? 1 : 0}"

  key_name_prefix = "${module.tls_private_key.private_key_name}-"
  public_key      = "${module.tls_private_key.public_key_openssh}"
}
