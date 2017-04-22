data "template_file" "master" {
  template = "${ file("${ path.module }/cloudinit/master.tpl") }"
  vars {
    etcd_token = "${ var.etcd_token }"
  }
}

resource "digitalocean_droplet" "master" {

  count = "${ var.master_count }"

  name   = "master-0${ count.index + 1 }"
  region = "${ var.region }"
  image  = "${ var.master["image"] }"
  size   = "${ var.master["size"] }"

  private_networking = "${ var.master["private_networking"] }"
  ssh_keys = [ "${ var.ssh_key_fingerprint }" ]

  user_data = "${ data.template_file.master.rendered }"

}
