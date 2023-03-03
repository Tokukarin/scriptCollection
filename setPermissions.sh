#!/bin/bash

#
# This script adjusts the permissions for specific folders to the GUID 100000.
# As unprivileged Proxmox container do not have permission levels higher than 100000.
#
# This keeps the Proxmox Host safe, If a container has been hacked.
#
# Each VM has a different subdirectory to keep the data seperated and safe in case of a infection.
#

echo "Setting Permissions"

echo "Setting Nextcloud (VM 110 ID) Permissions"
chown 100000:100000 /datastore/nextcloud/ -R

echo "Done"
exit 0
