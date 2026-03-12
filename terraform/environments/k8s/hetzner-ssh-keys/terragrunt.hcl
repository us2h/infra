terraform {
  source = "../../../modules/hetzner_keys"
}

inputs = {
  ssh_key_name   = "us2h-ssh-key"
  ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF/NLaoutooC1CJC1TEVdtiaZ0lfdz/QAe2CfN693c9T"
}

include "root" {
  path = find_in_parent_folders("hcloud_root.hcl")
}
