#!/bin/bash

source includes/display_module_input.sh
source includes/display_site_input.sh

timestamp=$(date +%Y%m%d%H%M%S)
minimum_size=9000

# Return the status of a module we are about to delete
function check_sites_default_module_status() {
  module_status=`drush @dev.$sitename pmi --fields=status $modulename | tr -d ' ' | sed -n -e 's/Status://p'`
  echo $module_status
}

# Collect criteria for which modules to delete on which sites
if (whiptail --title "Query information about sites and modules" --yes-button "One Module" --no-button "One Site (TBD)"  --yesno "Do you want to know about one module on multiple sites or multiple modules on one site?" 10 60) then
  display_module_input
else
  display_site_input
fi

# Confirm plan and report results
if (whiptail --title "Confirmation" --yes-button "PROCEED" --no-button "Cancel"  --yesno "Please confirm that you would like to delete $MODULE_INPUT from "${SITES_SELECTION[@]}".  Only if its status is "${STATUS_SELECTION[@]}" and difference is "${DIFFERENCE_SELECTION[@]}"." 10 60) then 
  confirmation_of_results=()
  for sitename in "${SITES_SELECTION[@]}";
  do
    # Strip quotes from user input
    sitename="${SITES_SELECTION%\"}"
    sitename="${sitename#\"}"
    modulename="${MODULE_INPUT%\"}"
    modulename="${modulename#\"}"

    confirmation_of_results+=("$sitename, $modulename, $module_status")
  done
  echo "${confirmation_of_results[*]}"
  ( IFS=$'\n'; echo "${confirmation_of_results[*]}" ) > /tmp/query_modules.output
  else
    exit
fi
