#!/bin/bash

set -e  # Exit on error

# Update packages and install dependencies
apt update -y
apt install -y wget unzip apache2

# Enable and start Apache
systemctl enable apache2
systemctl start apache2

# Download the template
TEMPLATE_URL="https://templatemo.com/tm-zip-files-2020/templatemo_589_lugx_gaming.zip"
TEMPLATE_FILE="templatemo_589_lugx_gaming.zip"

echo "Downloading template..."

if wget --header="User-Agent: Mozilla/5.0" "$TEMPLATE_URL" -O "$TEMPLATE_FILE"; then
    unzip -o "$TEMPLATE_FILE"
    cp -r templatemo_589_lugx_gaming/* /var/www/html/
    systemctl restart apache2
    echo "Website deployed!"
else
    echo "Failed to download template."
    exit 1
fi