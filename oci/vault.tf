resource "oci_kms_vault" "k8s_vault" {
  compartment_id = var.compartment_id
  display_name   = "k8s-vault"
  vault_type     = "DEFAULT"
}

resource "oci_kms_key" "k8s_master_key" {
  compartment_id = var.compartment_id
  display_name   = "k8s-master-key"
  management_endpoint = oci_kms_vault.k8s_vault.management_endpoint

  key_shape {
    algorithm = "AES"
    length    = 32
  }
}