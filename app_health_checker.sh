#!/bin/bash

URL="https://www.google.com"

STATUS=$(curl -o /dev/null -s -w "%{http_code}" $URL)

echo "HTTP Status Code: $STATUS"

if [ "$STATUS" -eq 200 ]; then
    echo "Application is UP"
else
    echo "Application is DOWN"
fi