#!/bin/bash
#add fix to exercise3 here

# Define the path to the Apache configuration file
apache_config="/etc/apache2/sites-enabled/000.-default.conf"  # Replace with the actual path

# Check if the Apache config file exists
if [ -f "$apache_config" ]; then
    # Modify the Require directive within the Location block
    sudo sed -i '/<Location "\/">/,/<\/Location>/ s/Require all denied/Require all granted/' "$apache_config"

    echo "Apache configuration updated."
    sudo service apache2 restart
else
    echo "Apache configuration file not found."
fi
