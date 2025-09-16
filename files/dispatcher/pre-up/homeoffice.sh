#!/bin/bash

# TASK
# ----
# When interface "homeoffice" is activated (VPN) try to mount all fstab entries again

INTERFACE="${1}"
EVENT="${2}"

if [[ "${INTERFACE}" == "homeoffice" ]]; then
    case "${EVENT}" in
        "up")
            echo "mount --all"
            mount --verbose --all --fork
            ;;
    esac
fi