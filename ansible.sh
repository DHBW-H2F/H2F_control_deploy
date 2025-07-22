#!/bin/bash
# update the last data of the github deployement
git pull

# clean
clear
# Step 1: Main action choice
echo "What would you like to do?"
echo "1) Clean (remove previous installation)"
echo "2) Install (set up services)"
echo "3) Rebuild ( clean + install )"
echo "4) Exit"

read -p "Enter your choice: " action_choice

# Validate main choice
case $action_choice in
  1)
    mode="install"
    ;;
  2)
    mode="clean"
    ;;
  3)
    mode="rebuild"
    ;;
  4)
    mode="start"
    ;;
  5)
    mode="stop"
    ;;
  6)
    echo "Exiting."
    exit 0
    ;;
  *)
    echo "Invalid choice."
    exit 1
    ;;
esac
clear

case $mode in
  install)
    echo "Select the services you want to install:"
    echo "1) Install Grafana"
    echo "2) Install WebUI"
    echo "3) Install Bridge"
    echo "0) Exit"
    declare -A tag_map=(
    [1]="install-grafana, "
    [2]="install-webui"
    [3]="install-bridge"
    )
    ;;
  clean)
    echo "Select the services you want to Clean:"
    echo "1) Clean Grafana"
    echo "2) Clean WebUI"
    echo "3) Clean Bridge"
    echo "0) Exit"
    declare -A tag_map=(
    [1]="clean-grafana, "
    [2]="clean-webui"
    [3]="clean-bridge"
    )
    ;;
  rebuild)
    echo "Select the services you want to Rebuild:"
    echo "1) Rebuild Grafana"
    echo "2) Rebuild WebUI"
    echo "3) Rebuild Bridge"
    echo "0) Exit"
    declare -A tag_map=(
    [1]="clean-grafana,install-grafana"
    [2]="clean-webui,install-webui"
    [3]="clean-bridge,install-bridge"
    )
    ;;
  start)
    echo "Select the services you want to start:"
    echo "1) Start Grafana"
    echo "2) Start WebUI"
    echo "3) Start Bridge"
    echo "0) Exit"
    declare -A tag_map=(
    [1]="install-grafana"
    [2]="install-webui"
    [3]="install-bridge"
    )
    ;;
  stop)
    echo "Select the services you want to stop:"
    echo "1) Stop Grafana"
    echo "2) Stop WebUI"
    echo "3) Stop Bridge"
    echo "0) Exit"
    declare -A tag_map=(
    [1]="clean-grafana"
    [2]="clean-webui"
    [3]="clean-bridge"
    )
    ;;

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
