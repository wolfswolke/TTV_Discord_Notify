#!/bin/bash

if [ -z "$CHANNEL_NAME" ]
then
      echo "\$CHANNEL_NAME is empty"
      exit 99
fi
if [ -z "$WEBHOOK_URL" ]
then
      echo "\$WEBHOOK_URL is empty"
      exit 99
fi
if [ -z "$COLOR" ]
then
      echo "\$COLOR is empty"
      exit 99
fi
# Check VOD Url. If empty set https://vod.zkwolf.com/info/${CHANNEL_NAME}. Else set custom VOD URL and add ${CHANNEL_NAME} to the end
if [ -z "$VOD_URL" ]
then
      VOD_URL="https://vod.zkwolf.com/info/${CHANNEL_NAME}"
else
      VOD_URL="${VOD_URL}${CHANNEL_NAME}"
fi

CHANNEL_URL="https://www.twitch.tv/${CHANNEL_NAME}"
STREAM_PREVIEW="https://static-cdn.jtvnw.net/previews-ttv/live_user_${CHANNEL_NAME}-1920x1080.jpg"

if [[ "${DEV}" == "true" ]]; then
  WEBHOOK_URL="${WEBHOOK_URL_DEV}"
fi

send_webhook() {
  local payload
  payload=$(cat <<EOF
{
  "content": "${CHANNEL_NAME} is now live!",
  "embeds": [{
    "title": "${CHANNEL_NAME}",
    "url": "${CHANNEL_URL}",
    "color": ${COLOR},
    "image": {
      "url": "${STREAM_PREVIEW}"
    },
    "author": {
      "name": "${CHANNEL_NAME} is now live!"
    },
    "fields": [
      {
        "name": "Game",
        "value": "$1",
        "inline": true
      },
      {
        "name": "Title",
        "value": "$2",
        "inline": true
      }
    ]
  }]
}
EOF
)

  local response
  response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/json" -d "${payload}" "${WEBHOOK_URL}")
  if [[ "$response" -eq 204 ]]; then
    echo "Webhook sent successfully at $(date)"
  else
    echo "Failed to send webhook at $(date)"
    echo "Response code: $response"
  fi
}

get_ttv_info() {
  local response
  response=$(curl -s "${VOD_URL}")
  if [[ -z "${response}" || "${response}" == "{}" ]]; then
    echo "null"
  else
    echo "${response}" | jq -e 'if . == {} then error("empty document found") else . end'
  fi
}

# Main loop
message_sent=false
while true; do
  echo "Checking for ${CHANNEL_NAME} at $(date)"
  ttv_info=$(get_ttv_info 2>/dev/null || echo "null")
  if [[ "${ttv_info}" == "null" ]]; then
    message_sent=false
  else
    stream_title=$(echo "${ttv_info}" | jq -r '.stream_title // empty')
    stream_game=$(echo "${ttv_info}" | jq -r '.stream_game // empty')

    if [[ -n "${stream_title}" && -n "${stream_game}" ]]; then
      if [[ "${message_sent}" == "false" ]]; then
        send_webhook "${stream_game}" "${stream_title}"
        message_sent=true
      fi
    else
      message_sent=false
    fi
  fi
  sleep 300
done
