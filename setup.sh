#!/bin/bash

# Update system packages
sudo apt-get update

# Install PostgreSQL and pgAdmin
sudo apt-get install -y postgresql postgresql-contrib pgadmin4

# Create a new PostgreSQL database named "predico"
sudo -u postgres createdb predico

# Install the project requirements
pip install -r requirements.txt

# Run Django migrations
python manage.py makemigrations
python manage.py migrate

# Start the Django server
python manage.py runserver