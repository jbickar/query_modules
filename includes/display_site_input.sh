#!/bin/bash

source includes/display_modules_menu.sh

function display_site_input() {
  SITE_INPUT=$(whiptail --title "Site" --inputbox "Which site would you like to dedupe?" 10 60 3>&1 1>&2 2>&3)
  exitstatus=$?
  if [ $exitstatus == 0 ]; then
    display_modules_menu
    echo $SITE_INPUT
  else
    exit
  fi
}
