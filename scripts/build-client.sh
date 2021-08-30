#!/bin/bash

scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
baseLocation=${scriptDir%scripts}
sourceLocation="${baseLocation}client/"
buildLocation="${baseLocation}nginx-configuration/static/"
distLocation="${baseLocation}dist/"
buildArchive="${distLocation}client-app.zip"
envFile="${baseLocation}.env"

if [[ ! -f "$envFile" ]]; then
  echo ".env file is not found in $baseLocation"
  exit 1
fi

# export all env vars
set -o allexport
source $envFile
set +o allexport

if [[ -z $ENV_CONFIGURATION ]]; then
  echo 'missing ENV_CONFIGURATION property in .env file'
  exit 1
fi

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