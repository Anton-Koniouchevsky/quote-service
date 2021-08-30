# This file contains all commands that was used to create API Gateway endpoint with Lambda binding

# Create Lambda function
aws lambda create-function \
  --function-name quote-notifier \
  --zip-file fileb://function.zip \
  --handler index.handler \
  --runtime nodejs12.x \
  --role arn:aws:iam::821845795844:role/lambda-ex

# Create API Gateway
aws apigateway create-rest-api --name 'Share Quote' --region eu-west-1
# API id: smxultzyo0

# Get the root resource id
aws apigateway get-resources --rest-api-id smxultzyo0 --region eu-west-1
# root resource id: 5u0fo8v0pe

# Create an API Gateway Resource
aws apigateway create-resource --rest-api-id smxultzyo0 \
  --region eu-west-1 \
  --parent-id 5u0fo8v0pe \
  --path-part share
# endpoint id: mwcs3t

# Create a POST method
aws apigateway put-method \
  --rest-api-id smxultzyo0 \
  --resource-id mwcs3t \
  --http-method POST \
  --authorization-type NONE

# Set up integration of the POST /share endpoint with the Lambda function
aws apigateway put-integration \
  --rest-api-id smxultzyo0 \
  --resource-id mwcs3t \
  --http-method POST \
  --type AWS_PROXY \
  --integration-http-method POST \
  --uri arn:aws:apigateway:eu-west-1:lambda:path/2015-03-31/functions/arn:aws:lambda:eu-west-1:821845795844:function:quote-notifier/invocations

# Deploy the API to the dev stage
aws apigateway create-deployment --rest-api-id smxultzyo0 --stage-name dev