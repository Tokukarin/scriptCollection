#!/bin/bash

#
# Let Nextcloud know about files that have been added outside of the nextcloud interface
#
# Background script
#

/srv/nextcloud/occ files:scan --all
