# #!/bin/bash
# cd /var/www/flaskapp
# pip3 install -r requirements.txt
# nohup python3 app.py > app.log 2>&1 &

#!/bin/bash

# Update package list and install Python and pip
sudo apt-get update -y
sudo apt-get install python3 python3-pip python3-venv -y

# Navigate to the Flask application directory
cd /var/www/flaskapp || exit

# Create a virtual environment (if it doesn't exist already)
if [ ! -d "venv" ]; then
    python3 -m venv venv
    echo "Virtual environment created."
fi

# Activate the virtual environment
source venv/bin/activate

# Install Python dependencies inside the virtual environment
pip install -r requirements.txt

# Deactivate any running instances of the application
if pgrep -f "python3 app.py"; then
    echo "Stopping existing application..."
    pkill -f "python3 app.py"
fi

# Start the Flask application in the background using the virtual environment's Python
nohup venv/bin/python app.py > app.log 2>&1 &

echo "Flask application started successfully."

# Deactivate the virtual environment
deactivate
