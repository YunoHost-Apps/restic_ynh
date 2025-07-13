#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

RESTIC_VERSION="0.18.0"

systemd_services_suffixes=( "" "_check" "_check_read_data" )

_gen_and_save_public_key() {
    public_key=""

    if [[ -n "$server" ]]; then
        private_key="/root/.ssh/id_${app}_ed25519"
        if [ ! -f "$private_key" ]; then
            ssh-keygen -q -t ed25519 -N "" -f "$private_key"
        fi
        public_key=$(cat "$private_key.pub")
    fi

    ynh_app_setting_set --key=public_key --value="$public_key"
}