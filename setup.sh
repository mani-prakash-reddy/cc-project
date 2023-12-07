#!/bin/bash

# Update system packages
echo "Updating system packages..."
sudo apt-get update

# Install PostgreSQL and pgAdmin
echo "Installing PostgreSQL and pgAdmin..."
sudo apt-get -y install postgresql postgresql-contrib pgadmin4

# Create a new PostgreSQL database named "predico"
echo "Creating a new PostgreSQL database..."
sudo -u postgres createdb predico

# Install python3 and pip
echo "Installing python3 and pip..."
sudo apt-get -y install python3.10 python3-pip

# Install the project requirements
echo "Installing project requirements..."
pip install -r requirements.txt

# Run Django migrations
echo "Running Django migrations..."
python3 manage.py makemigrations
python3 manage.py migrate

# Start the Django server
echo "Starting the Django server..."
python3 manage.py runserver