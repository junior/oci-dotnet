# Copyright (c) 2021 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
# 

terraform {
  required_version = ">= 0.13"
  required_providers {
    local    = { source = "hashicorp/local" }
    oci      = { source = "hashicorp/oci" }
    random   = { source = "hashicorp/random" }
    tls      = { source = "hashicorp/tls" }
    template = { source = "hashicorp/template" }
  }
}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  region       = local.region_to_deploy

  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
}

provider "oci" {
  alias        = "home_region"
  tenancy_ocid = var.tenancy_ocid
  region       = lookup(data.oci_identity_regions.home_region.regions[0], "name")

  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
}

provider "oci" {
  alias        = "current_region"
  tenancy_ocid = var.tenancy_ocid
  region       = var.region

  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
}

locals {
  region_to_deploy = var.use_only_always_free_elegible_resources ? lookup(data.oci_identity_regions.home_region.regions[0], "name") : var.region
}