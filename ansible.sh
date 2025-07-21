#!/bin/bash

clear
# Step 1: Main action choice
echo "What would you like to do?"
echo "1) Clean (remove previous installation)"
echo "2) Install (set up services)"
echo "3) Exit"

read -p "Enter your choice: " action_choice

# Validate main choice
case $action_choice in
  1)
    mode="clean"
    ;;
  2)
    mode="install"
    ;;
  3)
    echo "Exiting."
    exit 0
    ;;
  *)
    echo "Invalid choice."
    exit 1
    ;;
esac
clear
# Step 2: Choose services based on selected mode
if [[ $mode == "clean" ]]; then
  echo "Select the services you want to clean:"
  echo "1) Full Clean"
  echo "2) Clean Grafana"
  echo "3) Clean WebUI"
  echo "4) Clean Bridge"
  echo "0) Exit"

  declare -A tag_map=(
    [1]="fullclean"
    [2]="clean-grafana"
    [3]="clean-webui"
    [4]="clean-bridge"
  )
else
  echo "Select the services you want to install:"
  echo "1) Install All"
  echo "2) Install Grafana"
  echo "3) Install WebUI"
  echo "4) Install Bridge"
  echo "5) Install Traefik"
  echo "6) Install Kiosk"
  echo "0) Exit"

  declare -A tag_map=(
    [1]="install-all"
    [2]="install-grafana"
    [3]="install-webui"
    [4]="install-bridge"
    [5]="install-traefik"
    [6]="install-kiosk"
  )
fi

# Read service selections
read -p "Enter the number(s) separated by spaces: " input

# Build list of tags
selected_tags=""
for i in $input; do
  if [[ "$i" == "0" ]]; then
    echo "Exiting."
    exit 0
  elif [[ ${tag_map[$i]+_} ]]; then
    selected_tags+="${tag_map[$i]},"
  else
    echo "Invalid option: $i"
    exit 1
  fi
done

# Trim trailing comma
selected_tags="${selected_tags%,}"

# Run Ansible with selected tags
if [ -n "$selected_tags" ]; then
  echo "Running: ansible-playbook -v -i inventory/hosts playbook.yaml --tags  \"$selected_tags\""
  ansible-playbook -v -i inventory/hosts playbook.yaml --tags "$selected_tags"

else
  echo "No tags selected. Exiting script."
fi
