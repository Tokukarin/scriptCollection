#!/bin/bash

#
# This script adjusts permissions on a directory that has been passthroughed.
#

# Variables

## Nextcloud web user
htuser='www-data'
htgroup='www-data'

# self explanatory
rootuser='root'

# Path to the nextcloud instance
NCPATH='/srv/nextcloud'

# Path to the directory that has been passthroughed and needs the correct permissions
NCDATAPATH='/mnt/nextcloud'

echo "chmod Files and Directories"

find "${NCPATH}"/ -type f -print0 | xargs -0 chmod 0640
find "${NCPATH}"/ -type d -print0 | xargs -0 chmod 0750
find "${NCDATAPATH}"/ -type f -print0 | xargs -0 chmod 0640
find "${NCDATAPATH}"/ -type d -print0 | xargs -0 chmod 0750

echo "chown Directories"

chown -R "${rootuser}":"${htgroup}" "${NCPATH}"/
chown -R "${rootuser}":"${htgroup}" "${NCDATAPATH}"/
chown -R "${htuser}":"${htgroup}" "${NCPATH}"/apps/
chown -R "${htuser}":"${htgroup}" "${NCPATH}"/config/
chown -R "${htuser}":"${htgroup}" "${NCPATH}"/themes/
chown -R "${htuser}":"${htgroup}" "${NCPATH}"/updater/

# Nextcloud datafolder

echo "Nextcloud Datafolder"
if [ -d "${NCDATAPATH}" ]
then
    # Always chown root dir
    chown "${htuser}":"${htgroup}" "${NCDATAPATH}"/

    echo "Fix this"
    # Check subdirs as well
    if find "${NCDATAPATH}" -maxdepth 2 -type d -exec stat --printf='%U:%G\n' {} \; | grep -v "${htuser}":"${htgroup}"
    echo "Until this" 
   then
        chown -R "${htuser}":"${htgroup}" "${NCDATAPATH}"/
    fi
    # Also always chown files_external (https://github.com/nextcloud/vm/issues/2398)
    if [ -d "${NCDATAPATH}"/files_external ]
    then
        chown -R "${htuser}":"${htgroup}" "${NCDATAPATH}"/files_external
    fi
fi

echo "Main Path"
chmod +x "${NCPATH}"/occ

if [ -f "${NCPATH}"/.htaccess ]
then
    chmod 0644 "${NCPATH}"/.htaccess
    chown "${htuser}":"${htgroup}" "${NCPATH}"/.htaccess
fi
if [ -f "${NCDATA}"/.htaccess ]
then
    chmod 0644 "${NCDATA}"/.htaccess
    chown "${htuser}":"${htgroup}" "${NCDATA}"/.htaccess
fi

echo "Done"
exit 0
