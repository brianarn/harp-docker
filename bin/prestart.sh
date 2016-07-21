#!/bin/bash

SITE=site

# Ensure that site location exists
if [ ! -d $SITE ]; then
  echo Directory $SITE does not exist, creating ...
  mkdir $SITE;
else
  echo Directory $site exists
fi

# If it's empty, put some harp into it
if [ -n "$(find $SITE -prune -empty)" ]; then
  echo Nothing exists in the $SITE directory, initializing Harp
  harp init $SITE
else
  echo Something is in $SITE and so moving on
fi
