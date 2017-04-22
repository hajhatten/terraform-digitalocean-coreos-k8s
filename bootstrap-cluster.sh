#!/bin/bash

function setup_vars {
    printf "\nSetting up variables...\n"
    
    master_count=3
    etcd_token=$(curl -s "https://discovery.etcd.io/new?size=$master_count")
    
    ssh_key_fingerprint=${DIGITALOCEAN_SSH:?Need to set environment variable}
    do_token=${DIGITALOCEAN_TOKEN:?Need to set environment variable}
}

function print_vars {
    printf "\nVariables setup:"
    echo "Number of master nodes:" $master_count
    echo "ETCD discovery token:" $etcd_token
    echo "Digitalocean token:" $do_token
    echo "SSH key fingerprint:" $ssh_key_fingerprint
}

function validate {
    printf "\nPerforming terraform validate\n"
    echo "Variables not used in terraform syntax validation"
    if terraform validate; then
        echo "Syntax OK"
    fi
}

function plan {
    setup_vars
    print_vars

    echo "Performing terraform plan"
    terraform plan \
        -var ssh_key_fingerprint=$ssh_key_fingerprint \
        -var etcd_token=$etcd_token \
        -var master_count=$master_count \
        -var do_token=$do_token
}

function apply {
    setup_vars
    print_vars

    echo "Performing terraform apply"
    terraform apply \
        -var ssh_key_fingerprint=$ssh_key_fingerprint \
        -var etcd_token=$etcd_token \
        -var master_count=$master_count \
        -var do_token=$do_token
    terraform show
}

function destroy {
    setup_vars
    print_vars

    echo "Performing terraform destroy"
    terraform destroy -force \
        -var ssh_key_fingerprint=$ssh_key_fingerprint \
        -var etcd_token=$etcd_token \
        -var master_count=$master_count \
        -var do_token=$do_token
}

function help {
    cat << EOF
Usage for bootstrap-cluster.sh

--validate : validate variables and terraform configuration
-p, --p : plans coreos cluster
-a, --apply : applies coreos cluster
-d, --destroy : destroys coreos cluster
EOF
}

if [ $# -lt 1 ]; then
    printf "\nArgument not defined\n\n"
    help
    exit 1
fi

while test $# -gt 0; do
    case "$1" in
        -p|--plan)
            validate
            plan
            exit 0
            ;;
        -a|--apply)
            validate
            apply
            show
            exit 0
            ;;
        -d|--destroy)
            destroy
            exit 0
            ;;
        --validate)
            setup_vars
            validate
            exit 0
            ;;
        -h|--help)
            help
            exit 0
            ;;
        *)
            help
            printf "\nArgument not defined\n"
            exit 1
            ;;
    esac
done