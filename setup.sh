#!/bin/bash

# Update system packages
echo "Updating system packages..."
sudo apt-get update

# Install PostgreSQL and pgAdmin
echo "Installing PostgreSQL and pgAdmin..."
sudo apt-get -y install postgresql postgresql-contrib pgadmin4

# Create a new PostgreSQL user
echo "Creating a new PostgreSQL user..."
sudo -u postgres createuser postgres

# Set password for the new PostgreSQL user
echo "Setting password for the new PostgreSQL user..."
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '1234';"

# Grant all privileges of the database to the new user
echo "Granting all privileges of the database to the new user..."
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE predico TO postgres;"

# Check if PostgreSQL is running
pgrep postgres > /dev/null && echo "PostgreSQL is already running" || sudo service postgresql start

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