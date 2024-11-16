# TTV Live Notifier
Very small script to notify a Discord channel when a Twitch streamer goes live.

This script uses the [Twitch API wrapper](https://github.com/jenslys/twitch-api-wrapper) made by Jenslys.

The script by default uses https://vod.zkwolf.com/info/ChannelName to get the stream information.

If you  want to change that see the optional environment variables.

# How to use
1. Docker pull the image `docker pull ghcr.io/wolfswolke/ttv_discord_notifier:latest`
2. Run the image with the required environment variables.

# Environment Variables
`CHANNEL_NAME=YourChannelName` - The name of the channel you want to check for live status.

`DEV=false` - Weather to use the DEV webhook or not.

`WEBHOOK_URL=https://discord.com/api/webhooks/a/b` - Your public Discord Webhook URL

`COLOR=INT` - The color of the embed message. (Like: 6553771)

# Optional Environment Variables

If you set `DEV=true` you will need to set the following environment variables.

`WEBHOOK_URL_DEV=https://discord.com/api/webhooks/a/b` - Your Testing Discord Webhook URL. 

If you want to use your own Twitch API wrapper, you can set the following environment variables.

`VOD_URL=https://YourApi.TLD/info/` (Channel Name will be appended to the end of the URL)
