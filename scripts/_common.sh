#!/bin/bash

#=================================================
# COMMON VARIABLES
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

    ynh_app_setting_set --app="$app" --key=public_key --value="$public_key"
}

_set_ssh_config() {
    if grep -q "$app" "/root/.ssh/config" 2>/dev/null; then
        return 0
    fi

    cat << EOCONF >> /root/.ssh/config
# begin $app ssh config
Host ${server}
  Hostname ${server}
  Port ${port}
  User ${ssh_user}
  IdentityFile ${private_key}
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
# end $app ssh config
EOCONF

}


#=================================================
# COMMON HELPERS
#=================================================

_ynh_add_config_j2() {
    # Declare an array to define the options of this helper.
    local legacy_args=tdv
    local -A args_array=([t]=template= [d]=destination=)
    local template
    local destination
    # Manage arguments with getopts
    ynh_handle_getopts_args "$@"
    local template_path

    if [ -f "$YNH_APP_BASEDIR/conf/$template" ]; then
        template_path="$YNH_APP_BASEDIR/conf/$template"
    elif [ -f "$template" ]; then
        template_path=$template
    else
        ynh_die --message="The provided template $template doesn't exist"
    fi

    ynh_backup_if_checksum_is_different --file="$destination"

    # Make sure to set the permissions before we copy the file
    # This is to cover a case where an attacker could have
    # created a file beforehand to have control over it
    # (cp won't overwrite ownership / modes by default...)
    touch $destination
    chown root:root $destination
    chmod 640 $destination

    ynh_render_template "$template_path" "$destination"

    _ynh_apply_default_permissions $destination

    ynh_store_file_checksum --file="$destination"
}
