#!/bin/bash

CREATED_AT="$(date +%s)"

# build an image
docker build . -t quote-service:latest

# assign proper tags
docker tag quote-service:latest 821845795844.dkr.ecr.eu-west-1.amazonaws.com/backend-builds:latest
docker tag quote-service:latest 821845795844.dkr.ecr.eu-west-1.amazonaws.com/backend-builds:$CREATED_AT

# get access to ECR
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 821845795844.dkr.ecr.eu-west-1.amazonaws.com/backend-builds

# push builds to ECR
docker push 821845795844.dkr.ecr.eu-west-1.amazonaws.com/backend-builds:latest
docker push 821845795844.dkr.ecr.eu-west-1.amazonaws.com/backend-builds:$CREATED_AT
