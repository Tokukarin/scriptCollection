#!/bin/bash

#
# Background script to be executed everyday
#

# Variables
export PBS_PASSWORD= Add PW
export PBS_ENCRYPTION_PASSWORD= Add Encryption
export PBS_REPOSITORY=backupuser@pbs@10.0.1.210:backup

# Execute backup
proxmox-backup-client backup root.pxar:/ etc.pxar:/etc

# Set empty variables for security
export PBS_PASSWORD=
export PBS_REPOSITORY=
