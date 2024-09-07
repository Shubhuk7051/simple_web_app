#!/bin/bash

# Set the working directory
APP_DIR="/home/ubuntu/projects/flaskapp"
DOCKER_IMAGE="flaskapp"
DOCKER_REPO="shubhuk01/flaskapp"
DOCKER_TAG=${DOCKER_TAG:-latest}  # Default to 'latest' if DOCKER_TAG is not set
CONTAINER_NAME="flaskapp_container"

# Create the working directory if it doesn't exist
mkdir -p ${APP_DIR}

# Stop and remove any existing Docker containers
if docker ps -q --filter "name=${CONTAINER_NAME}"; then
    echo "Stopping existing container..."
    docker stop ${CONTAINER_NAME}
fi

if docker ps -aq --filter "name=${CONTAINER_NAME}"; then
    echo "Removing existing container..."
    docker rm ${CONTAINER_NAME}
fi

# Pull the latest Docker image from Docker Hub with dynamic tag
echo "Pulling Docker image ${DOCKER_REPO}:${DOCKER_TAG}..."
docker pull ${DOCKER_REPO}:${DOCKER_TAG}

# Run the Docker container
eecho "Starting the Docker container with image ${DOCKER_REPO}:${DOCKER_TAG}..."
docker run -d --name ${CONTAINER_NAME} -p 5000:5000 ${DOCKER_REPO}:${DOCKER_TAG}

if [ $? -eq 0 ]; then
    echo "Flask application started successfully."
else
    echo "Failed to start the Flask application."
    exit 1
fi