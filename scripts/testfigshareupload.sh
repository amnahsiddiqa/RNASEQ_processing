#!/bin/bash

# Figshare API endpoint and access token
API_ENDPOINT="https://api.figshare.com/v2"
ACCESS_TOKEN="ef17542dac370485ece3b6fa34eeb272f6558c974457d170f795cf2df09d7c179633cea9e38a9df2d77284f07800c94fdf03c87fd6c83a9b14d815ce72f3274d"

# File information
FILE_PATH="/projects/sh-li-lab/share/SiddiqaA/play_shworkflow/1.dofastqc.sh.xz"
FILE_NAME="1.dofastqc.sh.xz"
FILE_TITLE="Title of your file"
FILE_DESCRIPTION="Description of your file"

# Create a new article
article_id=$(curl -s -H "Authorization: token $ACCESS_TOKEN" -H "Content-Type: application/json" -X POST -d "{\"title\":\"$FILE_TITLE\",\"description\":\"$FILE_DESCRIPTION\"}" $API_ENDPOINT/account/articles | jq -r '.location' | awk -F'/' '{print $NF}')

# Upload the file
curl -H "Authorization: token $ACCESS_TOKEN" -H "Content-Type: application/zip" -X POST --upload-file "$FILE_PATH" "$API_ENDPOINT/account/articles/$article_id/files?name=$FILE_NAME"
