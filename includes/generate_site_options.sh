#!/bin/bash

# Include function definition file
# source generate_sws_sites_list.sh
source includes/common.inc

# Setup variables
environment='dev'
sitename_prefix='/Users/kelliebrownell/Sites'
sitename_suffix=''

# We only want users to see a site appear once on the list of options.
function remove_duplicate_sites_from_options() {
  if ((`in_array "$sitename" "${site_options[@]}"` == 1)); then
    unset site_options[$counter]
    echo ${site_options[@]}
  fi
}

# Similarly, only present a site if its module status matches the criteria selected.
function remove_sites_based_on_module_status() {
  before_adding_site_module_status=$(check_sites_default_module_status)
  if ((`in_array $before_adding_site_module_status "${STATUS_SELECTION[@]}"` == 0)); then
    unset site_options[$counter]
    echo ${site_options[@]}
  fi
}

# Similarly, only present a site if its module in sites/default differs from the duplicate module in sites/all according to the criteria selected.
function remove_sites_based_on_difference() {
  if ((`in_array $module_difference "${DIFFERENCE_SELECTION[@]}"` == 0)); then
    unset site_options[$counter]
    echo ${site_options[@]}
  fi
}

# This module can review multiple sites and multiple modules on each site.
# It should return a list of sites that meet the criteria users input regarding:
# 1. Which module to remove.
# 2. Only if it matches the status provided.
# 3. And the difference provided.
# 4. Finally, there should be no duplicates on the list.
# Whiptail checklists require a "key" "value" format for checklist item lists.
# Further processesing happens in display_sites_menu.sh.
function generate_site_options() {
  site_options=()
  site_list=()
  counter=0
  while read sitename
  do
    # Only proceed if the site directory exists in your chosen environment
    if [ -d "$sitename_prefix/$sitename" ]; then
      sites_default_modules=(`ls $sitename_prefix/$sitename/sites/default/modules/contrib/`)
      if ((`in_array $MODULE_INPUT "${sites_default_modules[@]}"` == 1)); then
	module_difference="duplicate"
      else
	module_difference="no_duplicate"
      fi
      site_options+="$sitename"
      remove_duplicate_sites_from_options
      remove_sites_based_on_module_status
      remove_sites_based_on_difference
      if ((`in_array $sitename "${site_options[@]}"` == 0)); then
	site_list+=("\""$sitename\"" \""$sites_default_module\""")
      fi
      counter+=1
    fi
  done < data/sws_sites_list.data
  ( IFS=$'\n'; echo "${site_list[@]}" ) > data/site_options.data
}
