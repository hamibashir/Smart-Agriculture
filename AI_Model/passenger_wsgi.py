"""
passenger_wsgi.py - cPanel Python App Entry Point
cPanel's "Setup Python App" uses Phusion Passenger which looks for this file.
The Flask app must be exposed as a variable named 'application'.
"""
import sys
import os

# Ensure the app directory is in Python path
app_dir = os.path.dirname(os.path.abspath(__file__))
if app_dir not in sys.path:
    sys.path.insert(0, app_dir)

# Development:
#   Run directly: python app.py
# Production (cPanel Passenger):
#   This file is used automatically and must expose `application`.

# Import Flask app - Passenger expects a variable named 'application'
from app import app as application
