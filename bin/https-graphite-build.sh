#!/bin/bash -eu

# Build https-graphite container

tmpdir=$(mktemp -d)
wrkdir=$(pwd)

exit_handler() {
    if [ -d "${tmpdir}" ] ; then
        rm -rf "${tmpdir}"
    fi
}
trap exit_handler EXIT

cd "${tmpdir}"
git clone https://github.com/j-kali/https-graphite.git
cd https-graphite
docker build --rm --no-cache -t https-graphite .

cert_dir=${TRAEFIK_DATA:-/data/certs}
if [ ! -f "${cert_dir}/ca.crt" ] ; then
    mkdir -p "${cert_dir}"
    openssl req \
            -newkey rsa:4096 \
            -new \
            -nodes \
            -x509 \
            -days 3650 \
            -out "${cert_dir}/ca.crt" \
            -keyout "${cert_dir}/ca.key" \
            -subj "/C=FI/O=CSC/CN=${USER}@$(hostname)"
fi
