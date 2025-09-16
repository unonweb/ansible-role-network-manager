#!/bin/bash

# TASK
# ----
# Before interface "homeoffice" is deactivated (pre-down) unmount all of the given mountpoints

INTERFACE="${1}"
EVENT="${2}"

MOUNTPOINTS=(
	"/media/it"
	"/media/nasenbaer"
	"/media/personal"
	"/media/theke"
)

if [[ "${INTERFACE}" == "homeoffice" ]]; then

    # using gio (gnome input output) instead of umount to unmount makes nautilus aware of the unmounts
    # so we avoid nautilus to hang if trying to unmount an already unmounted device

	for mountpoint in "${MOUNTPOINTS[@]}"; do
		findmnt "${mountpoint}" > /dev/null
		if [[ $? == 0 ]]; then
			echo "gio mount --unmount ${mountpoint}"
			gio mount --unmount "${mountpoint}"
		fi	
	done

fi
