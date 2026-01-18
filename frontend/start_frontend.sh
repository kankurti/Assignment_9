#!/bin/bash

# Go to frontend folder
cd /home/ubuntu/Assignment_9/frontend

# Install dependencies (optional if already installed)
npm install

# Restart or start the Express app using PM2
pm2 delete express-app 2>/dev/null   # remove old instance if exists
pm2 start server.js \
    --name express-app \
    --watch \
    --env BACKEND_URL=http://localhost:5000

