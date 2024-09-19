#!/bin/bash

# Define the API endpoint
API_URL="https://jsonplaceholder.typicode.com/posts/1"

# Send a GET request to the API and store the response
response=$(curl -s $API_URL)

# Check if the response is not empty
if [ -z "$response" ]; then
  echo "No response from API."
  exit 1
fi

# Parse the JSON response using jq
title=$(echo $response | jq -r '.title')
body=$(echo $response | jq -r '.body')

# Display the parsed data
echo "Title: $title"
echo "Body: $body"

# Exit the script
exit 0