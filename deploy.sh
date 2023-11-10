#!/bin/bash

REPOSITORY_NAME="dcpro-images"
AWS_ACCOUNT_ID="enter account number"
REGION="us-east-1"
IMAGE_TAG="latest"
LOCAL_IMAGE_NAME="dcpro-images"
GO_SOURCE_FILE="./src/main.go"

echo "Compiling Go binary..."
GOOS=linux GOARCH=amd64 go build -o main $GO_SOURCE_FILE

if [ $? -ne 0 ]; then
    echo "Go build failed, exiting."
    exit 1
fi

docker build -t ${LOCAL_IMAGE_NAME} .
docker tag ${LOCAL_IMAGE_NAME}:${IMAGE_TAG} ${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPOSITORY_NAME}:${IMAGE_TAG}
aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPOSITORY_NAME}:${IMAGE_TAG}

echo "Docker image pushed to ECR."
