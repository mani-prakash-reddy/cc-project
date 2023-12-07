#!/bin/bash

# Update system packages
sudo apt-get update

# Install PostgreSQL and pgAdmin
sudo apt-get install postgresql postgresql-contrib pgadmin4

# Create a new PostgreSQL database named "predico"
sudo -u postgres createdb predico

# Install Python and pip
sudo apt-get install python3.10 python3-pip

# Install the project requirements
pip install -r requirements.txt

# Run Django migrations
python manage.py makemigrations
python manage.py migrate

# Start the Django server
python manage.py runserver