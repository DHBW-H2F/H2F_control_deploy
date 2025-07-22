#!/bin/bash

clear
echo "What would you like to do?"
echo "1) start webUI"
echo "2) Manage Services"

read -p "Enter your choice: " action_choice
# Validate main choice
case $action_choice in
  1)
    mode="webui"
    ;;
  2)
    mode="service"
    ;;
  *)
    echo "Invalid choice."
    exit 1
    ;;
esac
if [[ $mode == "webui" ]]; then
  mkdir -p /tmp/kiosk-profile;
  until curl -s --head --fail http://webui.h2f/ConfigurationPanel.html;
   do sleep 1;
  done;
  exec /usr/bin/cage -- firefox --no-remote --kiosk --private-window --profile /tmp/kiosk-prosk-profile http://webui.h2f/ConfigurationPanel.html
else
  docker exec -it setup /H2F_control_deploy/ansible.sh

fi