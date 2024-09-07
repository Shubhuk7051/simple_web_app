# Use an official Python runtime as a parent image
FROM python:3

# Set the working directory in the container
WORKDIR /home/ubuntu/projects/flaskapp

# Copy the requirements file into the container
COPY requirements.txt .

# Install any dependencies specified in requirements.txt
RUN pip install -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Expose port 5000 for the Flask application
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]