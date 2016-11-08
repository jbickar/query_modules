#!/bin/bash

source includes/display_sites_menu.sh
source includes/display_status_menu.sh
source includes/display_difference_menu.sh

function display_module_input() {
  MODULE_INPUT=$(whiptail --title "Module" --inputbox "Which module would you like to query?" 10 60 3>&1 1>&2 2>&3)
  exitstatus=$?
  if [ $exitstatus == 0 ]; then
    display_status_menu
    display_difference_menu
    display_sites_menu
    echo $MODULE_INPUT
  else
    exit
  fi
}
