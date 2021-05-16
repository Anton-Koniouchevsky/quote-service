#!/bin/bash

baseLocation="/d/cdp/devOps/quote-service"
sourceLocation="$baseLocation/client"
buildLocation="$baseLocation/static"
distLocation="$baseLocation/dist"
buildArchive="$distLocation/client-app.zip"

# export all env vars
set -o allexport
source "$baseLocation/.env"
set +o allexport

# build client
npm --prefix $sourceLocation run build:$ENV_CONFIGURATION

# create dist folder if needed
if [[ ! -d $distLocation ]]; then
  mkdir $distLocation
fi

# remove zip file if needed
if [[ -f $buildArchive ]]; then
  rm -rf $buildArchive
fi

# create new zip file
zip -r $buildArchive $buildLocation/