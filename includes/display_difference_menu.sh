#!/bin/bash

function display_difference_menu() {
  while read -r number text; do
    difference_options+=( ${number//\"} "${text//\"}" OFF// )
  done < data/difference_options.data
  DIFFERENCE_SELECTION=$(whiptail --title "sites/default Difference" --checklist "Limit results to sites with or without a duplicate copy of this module in sites/default." 15 60 3 "${difference_options[@]}" 3>&1 1>&2 2>&3)
  exitstatus=$?
  if [ $exitstatus == 0 ]; then
    echo "${DIFFERENCE_SELECTION[@]}"
  else
    exit
  fi
}
