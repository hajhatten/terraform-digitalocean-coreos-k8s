# Generate a CoreOS Kubernetes cluster with Terraform

# Required environment variables

* DIGITALOCEAN_TOKEN - Digitalocean API Token
* DIGITALOCEAN_SSH - SSH-key fingerprint to stored SSH-key at Digitalocean

## Usage

```./bootstrap-cluster.sh -h

Usage for bootstrap-cluster.sh

--validate : validate variables and terraform configuration
-p, --p : plans coreos cluster
-a, --apply : applies coreos cluster
-d, --destroy : destroys coreos cluster```