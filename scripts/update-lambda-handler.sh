#!/bin/bash

scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
baseLocation=${scriptDir%scripts}
sourceLocation="src/app/notifications/handlers/quote-notifier"

handler="${sourceLocation}/index.js"
archive="${sourceLocation}/function.zip"

# Create a deployment package.
zip -j $archive $handler

# Update Lambda function
aws lambda update-function-code \
  --function-name quote-notifier \
  --zip-file fileb://$archive \