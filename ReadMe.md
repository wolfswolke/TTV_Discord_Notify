# TTV Live Notifier
Very small script to notify a Discord channel when a Twitch streamer goes live.

# How to use
1. Docker pull the image `docker pull wolfswolke/TTV_Discord_Notifier`
2. Run the image with the required environment variables.
# Environment Variables
`CHANNEL_NAME=YourChannelName` - The name of the channel you want to check for live status.

`DEV=false` - Weather to use the DEV webhook or not.

`WEBHOOK_URL=https://discord.com/api/webhooks/a/b` - Your public Discord Webhook URL

`WEBHOOK_URL_DEV=https://discord.com/api/webhooks/a/b` - Your Testing Discord Webhook URL. (Only required if DEV=true)