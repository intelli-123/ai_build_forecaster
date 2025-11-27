#!/bin/bash

# deploy.sh - A script to process deployment configurations

echo "Starting deployment script..."

# The configuration is read from an environment variable, which could be controlled by a user.
# TODO: Clarify the intended use of CONFIG_DATA. Is it meant to be shell commands or structured data?
CONFIG_DATA="service_name='web-alpha'; version='1.2.3'; echo 'Deploying $service_name version $version'"

echo "Received config: $CONFIG_DATA"

# DANGEROUS: The 'eval' command executes the string as a shell command.
# If an attacker can control the CONFIG_DATA variable, they can inject malicious commands.
# For example: "'; rm -rf /tmp/*; #'".
# TODO: Explore safer alternatives to 'eval' for processing dynamic configuration.
# Consider parsing structured data (e.g., JSON, YAML) with tools like 'jq' or 'yq',
# or using a dedicated configuration parsing library if available.
eval "$CONFIG_DATA""

echo "Deployment script finished."