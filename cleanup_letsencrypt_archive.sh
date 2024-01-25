#!/bin/bash

function deleteall {
  for folder in /etc/letsencrypt/live/*; do
    delete $folder
  done
}

function delete {
  # Parse both the site name and full path (deleteall function)
  path=$1
  if [[ $1 != "/etc/letsencrypt/live/"* ]]; then
    path=/etc/letsencrypt/live/$1
  fi

  # Make an array with all files that are symlinks
  keep=()
  for file in $path/*; do
    keep+=($(readlink $file | awk -F"/" '{print $NF}'))
  done

  # Switch to the archive folder
  path=$(echo $path | sed 's/live/archive/')
  echo keeping "${keep[@]}" from $path

  # Go through the archive folder and delete everything that isn't a part of the array
  for file in $path/*; do
    if [[ "${keep[@]}" != *"$(echo $file | awk -F"/" '{print $NF}')"* ]] ; then
     echo deleting $file
     rm -f $file
    fi
  done
}

# Call the function(s)
$1 $2