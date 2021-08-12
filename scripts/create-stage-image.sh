#!/bin/bash

STAGE=$1
STORAGE=821845795844.dkr.ecr.eu-west-1.amazonaws.com/backend-builds

# pull latest image from ECR
docker pull $STORAGE:latest

# tag image with stage
docker tag $STORAGE:latest $STORAGE:$STAGE

# get access to ECR
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin $STORAGE

# push image to ECR
docker push $STORAGE:$STAGE