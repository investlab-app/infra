resource "oci_identity_dynamic_group" "k8s_nodes" {
  compartment_id = var.compartment_id
  description    = "Dynamic group for K8s worker nodes"
  matching_rule  = "ALL {instance.compartment.id = '${var.compartment_id}'}"
  name           = "k8s-nodes"
}

resource "oci_identity_policy" "k8s_secrets_policy" {
  compartment_id = var.compartment_id
  description    = "Policy to allow K8s nodes to read secrets"
  name           = "k8s-secrets-policy"
  statements     = [
    "Allow dynamic-group k8s-nodes to read vaults in compartment id ${var.compartment_id}",
    "Allow dynamic-group k8s-nodes to read keys in compartment id ${var.compartment_id}",
    "Allow dynamic-group k8s-nodes to read secret-bundles in compartment id ${var.compartment_id}"
  ]
}