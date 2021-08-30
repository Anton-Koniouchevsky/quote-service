#!/bin/bash

CREATED_AT="$(date +%s)"
STORAGE=821845795844.dkr.ecr.eu-west-1.amazonaws.com/backend-builds

# build an image
docker build . -t quote-service:latest

# assign proper tags
docker tag quote-service:latest $STORAGE:latest
docker tag quote-service:latest $STORAGE:$CREATED_AT

# get access to ECR
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin $STORAGE

# push builds to ECR
docker push $STORAGE:latest
docker push $STORAGE:$CREATED_AT
