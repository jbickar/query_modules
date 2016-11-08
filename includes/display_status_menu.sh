#!/bin/bash

function display_status_menu() {
  while read -r number text; do
    status_options+=( ${number//\"} "${text//\"}" OFF// )
  done < data/status_options.data
  STATUS_SELECTION=$(whiptail --title "Module Status" --checklist "Only return sites with the following module status(es)." 15 60 3 "${status_options[@]}" 3>&1 1>&2 2>&3)
  exitstatus=$?
  if [ $exitstatus == 0 ]; then
    echo "${STATUS_SELECTION[*]}"
  else
    exit
  fi
}
