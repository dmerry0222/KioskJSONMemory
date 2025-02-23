#!/bin/bash

# Define the repository and file details
REPO="dmerry0222/KioskJSONMemory"
FILE_PATH="status.json"
API_URL="https://api.github.com/repos/$REPO/contents/$FILE_PATH"

# Get the current status.json content (for demonstration, we'll assume you are updating it)
STATUS_CONTENT=$(cat status.json)

# Encode the status.json content to base64
ENCODED_CONTENT=$(echo -n "$STATUS_CONTENT" | base64)

# Make the API request to update the file using the GitHub API
curl -X PUT \
  -H "Authorization: token $GH_TOKEN" \
  -H "Content-Type: application/json" \
  -d @- <<EOF
{
  "message": "Update status.json",
  "committer": {
    "name": "dmerry0222",
    "email": "your-email@example.com"
  },
  "content": "$ENCODED_CONTENT",
  "sha": "$(curl -s -H "Authorization: token $GH_TOKEN" $API_URL | jq -r .sha)"
}
EOF

echo "Status updated successfully!"
