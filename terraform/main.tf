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

resource "oci_core_vcn" "foundry_vcn" {
    dns_label = "internal"
    cidr_block = "172.16.0.0/20"
    compartment_id = "<compartment-ocid>"
    display_name = "foundry VCN"
}

resource "oci_core_instance" "ubuntu_instance" {
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = "<compartment-ocid>"
    shape = "VM.Standard2.1"
    source_details {
      source_id = "<source-ocid>"
      source_type = "image"
    }

    display_name = "foundry-vm"
    create_vnic_details {
      assign_public_ip = true
      subnet_id = "<subnet-ocid>"
    }
    metadata = {
      ssh_authorized_keys = file("<ssh-public-key-path>")
    }
    preserve_boot_volume = false
}
