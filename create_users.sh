#!/bin/bash

# Log file paths
LOG_FILE="/var/log/user_management.log"
PASSWORD_FILE="/var/secure/user_passwords.csv"

# Function to log messages to log file
log() {
    echo "$(date +"%Y-%m-%d %T") $1" >> "$LOG_FILE"
}

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root." >&2
    exit 1
fi

# Check if input file is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

input_file="$1"

# Ensure log file exists and is writable
touch "$LOG_FILE"
chmod 640 "$LOG_FILE"

# Ensure password file exists and is writable by owner only
touch "$PASSWORD_FILE"
chmod 600 "$PASSWORD_FILE"

# Read input file line by line
while IFS=';' read -r username groups_raw; do
    # Trim whitespace from username and groups
    username=$(echo "$username" | tr -d '[:space:]')
    groups_raw=$(echo "$groups_raw" | tr -d '[:space:]')

    # Split groups by comma into array
    IFS=',' read -ra groups <<< "$groups_raw"

    # Check if user already exists
    if id "$username" &>/dev/null; then
        log "User $username already exists. Skipping creation."
        continue
    fi

    # Create personal group if it doesn't exist
    if ! grep -q "^$username:" /etc/group; then
        groupadd "$username"
        log "Group $username created."
    fi

    # Create additional groups if they don't exist
    for group in "${groups[@]}"; do
        if ! grep -q "^$group:" /etc/group; then
            groupadd "$group"
            log "Group $group created."
        fi
    done

    # Generate random password
    password=$(openssl rand -base64 12)
    
    # Create user with home directory and set password
    useradd -m -g "$username" -G "$(echo "${groups[*]}" | tr ' ' ',')" "$username"
    echo "$username:$password" | chpasswd
    
    # Log user creation and password generation
    log "User $username created with groups: ${groups[*]}. Password stored in $PASSWORD_FILE."

    # Store password securely
    echo "$username,$password" >> "$PASSWORD_FILE"

    # Set correct permissions on home directory
    chmod 700 "/home/$username"
    chown "$username:$username" "/home/$username"

done < "$input_file"

log "User creation process completed."
