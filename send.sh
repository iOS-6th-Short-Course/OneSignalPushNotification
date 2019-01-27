read -p "Enter message to send:" msg

curl --include \
--request POST \
--header "Content-Type: application/json; charset=utf-8" \
--header "Authorization: Basic API_KEY" \
--data-binary "{\"app_id\": \"e49685b9-b54f-4620-b33d-4df8c6fb62d1\",
\"contents\": {\"en\": \"$msg\"},
\"included_segments\": [\"Subscribed Users\"]}" \
https://onesignal.com/api/v1/notifications


echo "Notification sent"
