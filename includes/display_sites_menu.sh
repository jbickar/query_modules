#!/bin/bash

source includes/generate_site_options.sh

function display_sites_menu() {
  rm data/site_options.data
  touch data/site_options.data
  generate_site_options
  site_formatted_checklist=()
  # Checklist option format taken from http://stackoverflow.com/a/15230609
  while read -r number text; do
    site_formatted_checklist+=( ${number//\"} "${text//\"}" OFF// )
  done < data/site_options.data
  SITES_SELECTION=$(whiptail --title "Select Sites" --checklist "Limit query results to these sites with copy of $MODULE_INPUT. Press <space> to make your selection." 25 60 18 "${site_formatted_checklist[@]}" 3>&1 1>&2 2>&3)
   exitstatus=$?
   if [ $exitstatus == 0 ]; then
     echo "${SITES_SELECTION[*]}"
  else
    exit
  fi
}
