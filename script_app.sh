#!/bin/bash


gunicorn -b 0.0.0.0:4000 wsgi:app