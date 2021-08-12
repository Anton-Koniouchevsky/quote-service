#!/bin/bash

aws ecr put-lifecycle-policy --repository-name base-images --lifecycle-policy-text file://lifecycle-policies.json
aws ecr put-lifecycle-policy --repository-name backend-builds --lifecycle-policy-text file://lifecycle-policies.json