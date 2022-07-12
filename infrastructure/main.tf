terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  cloud {
    organization = "borealis-infra"

    workspaces {
      name = "borealis-data-domain"
    }
  }
}
