#!/bin/bash

source includes/generate_site_options.sh

function display_modules_menu() {
  MODULES_TO_DELETE_FROM_SITE=$(whiptail --title "Select Modules" --checklist "Only delete the following modules in sites/default from $SITE_INPUT." 15 60 3 "${module_options[@]}" 3>&1 1>&2 2>&3)
  exitstatus=$?
  if [ $exitstatus == 0 ]; then
    echo $MODULE_SELECTION
  else
    exit
  fi
}
