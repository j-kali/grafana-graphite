#!/bin/bash -eu

if [ "${#}" -lt 1 ] ; then
  echo "Usage: ${0} <password file>"
  exit 1
fi

if [ ! -f "${1}" ] ; then
  openssl rand -hex 32 > "${1}"
fi
