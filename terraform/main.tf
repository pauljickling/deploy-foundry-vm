terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

provider "oci" {
  region = "us-ashburn-1"
  auth = "OracleSecurityToken"
  config_file_profile = "default"
}
