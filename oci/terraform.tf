terraform {
  # backend "oci" {
  #   namespace = "???"
  #   bucket    = "investlab-terraform"
  #   key       = "terraform.tfstate"
  # }
  backend "s3" {
    region                      = "us-east-1"
    use_lockfile                = true
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    bucket                      = "investlab-terraform"
    key                         = "terraform.tfstate"
  }

  required_providers {
    jq = {
      source  = "massdriver-cloud/jq"
      version = "0.2.1"
    }
    oci = {
      source  = "oracle/oci"
      version = "~> 7.24.0"
    }
  }
}
