#!/bin/bash

# deploy.sh - A script to process deployment configurations

echo "Starting deployment script..."

# The configuration is read from an environment variable, which could be controlled by a user.
CONFIG_DATA="service_name='web-alpha'; version='1.2.3'; echo 'Deploying $service_name version $version'"

echo "Received config: $CONFIG_DATA"

# DANGEROUS: The 'eval' command executes the string as a shell command.
# If an attacker can control the CONFIG_DATA variable, they can inject malicious commands.
# For example: "'; rm -rf /tmp/*; #'"
eval "$CONFIG_DATA"

echo "Deployment script finished."