#!/bin/bash

set -eux

version=$(cat "${VERSION_FILE}")
title="New version of dependency ${DEPENDENCY} available: ${version}"
body="@${TAG_USER}"

response=$(curl -s -X POST \
  "https://api.github.com/repos/${OWNER}/${REPO}/issues" \
  -u "${USERNAME}:${ACCESS_TOKEN}" \
  -d @- <<EOF
{
  "title": "${title}",
  "body": "${body}"
}
EOF
)

echo "${response}" | jq -r ".html_url" > issue/url
