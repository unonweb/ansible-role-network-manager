#!/usr/bin/bash

# NetworkManager dispatcher script: Unmount CIFS shares before VPN/interface goes down

INTERFACE="${1:-}"
ACTION="${2:-}"

if [[ "${INTERFACE}" == "homeoffice" ]] && [[ "${ACTION}" == "pre-down" ]]; then

	# Check if any cifs shares are actually mounted before attempting unmount
    if mount -t cifs >/dev/null 2>&1; then
        # Use absolute paths and force option for unresponsive network drives
        /usr/bin/umount --all --types cifs --force --lazy || true
    fi
fi
