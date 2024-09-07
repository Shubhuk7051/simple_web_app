#!/bin/bash

# Update package list and install Python and pip
sudo apt-get update -y
sudo apt-get install python3 python3-pip -y

# Navigate to the Flask application directory
cd /var/www/flaskapp || exit

# Install Python dependencies
/usr/bin/pip3 install -r requirements.txt

# Check if the application is already running and stop it
if pgrep -f "python3 app.py"; then
    echo "Stopping existing application..."
    pkill -f "python3 app.py"
fi

# Start the Flask application in the background
nohup /usr/bin/python3 app.py > app.log 2>&1 &

echo "Flask application started successfully."
