#cloud-config

coreos:
  update:
    reboot-strategy: "etcd-lock"
    group: "stable"
  locksmith:
    window-start: Thu 04:00
    window-length: 1h
  etcd2:
    # generate a new token for each unique cluster from https://discovery.etcd.io/new?size=3
    discovery: "${ etcd_token }"
    advertise-client-urls: "http://$public_ipv4:2379"
    initial-advertise-peer-urls: "http://$private_ipv4:2380"
    listen-client-urls: "http://0.0.0.0:2379,http://0.0.0.0:4001"
    listen-peer-urls: "http://$private_ipv4:2380,http://$private_ipv4:7001"
  units:
    - name: "etcd2.service"
      command: "start"