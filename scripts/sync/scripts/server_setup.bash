#!/bin/bash
set -e  # exit on first error

symlink_config() {
    ln -fs ${PWD}/configs/rsyncd.conf /etc/rsyncd.conf
}

setup_secrets() {
    echo -n 'password for sync: '
    read -s PASS

    cat << EOF > /etc/rsyncd.secrets
rsyncclient:$PASS
chutsu:$PASS
backup:$PASS
user:$PASS
EOF
    chmod 600 /etc/rsyncd.secrets
}

symlink_config
setup_secrets
rsync --daemon

if [ $? -eq 0 ]; then
    echo "rsync is running!"
else
    echo "Failed to start rsync!"
fi
