#!/bin/bash

# Set the working directory
APP_DIR="/home/ubuntu/projects/flaskapp"
DOCKER_IMAGE="flaskapp:latest"

# Create the working directory if it doesn't exist
mkdir -p ${APP_DIR}

# Stop and remove any existing Docker containers
docker ps -q --filter "name=flaskapp_container" | xargs -r docker stop
docker ps -aq --filter "name=flaskapp_container" | xargs -r docker rm

# Pull the latest Docker image from the Docker registry
docker pull ${DOCKER_IMAGE}

# Run the Docker container
docker run -d --name flaskapp_container -p 5000:5000 ${DOCKER_IMAGE}

echo "Flask application started successfully."