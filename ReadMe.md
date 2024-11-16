# TTV Live Notifier
Very small script to notify a Discord channel when a Twitch streamer goes live.

This script uses the [Twitch API wrapper](https://github.com/jenslys/twitch-api-wrapper) made by Jenslys.

Im already pre hosting this wrapper publicly, so you don't have to worry about it if you don't want to.

# How to use
1. Docker pull the image `docker pull ghcr.io/wolfswolke/ttv_discord_notifier:latest`
2. Run the image with the required environment variables.

# Environment Variables
`CHANNEL_NAME=YourChannelName` - The name of the channel you want to check for live status.

`DEV=false` - Weather to use the DEV webhook or not.

`WEBHOOK_URL=https://discord.com/api/webhooks/a/b` - Your public Discord Webhook URL

# Optional Environment Variables

If you set `DEV=true` you will need to set the following environment variables.

`WEBHOOK_URL_DEV=https://discord.com/api/webhooks/a/b` - Your Testing Discord Webhook URL. 
