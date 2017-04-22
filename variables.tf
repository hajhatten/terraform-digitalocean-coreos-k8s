variable "region" {
    type = "string"
    default = "fra1"
}

variable "master_count" {}
variable "master"  {
    type = "map"
    default = {
        size = "512mb"
        image = "coreos-stable"
        private_networking = true
    }
}

variable "do_token" {}
variable "etcd_token" {}
variable "ssh_key_fingerprint" {}