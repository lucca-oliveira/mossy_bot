# frozen_string_literal: true

require 'discordrb'
require 'dotenv'
require 'pry'
require 'yt'

Dotenv.load('.env')

bot = Discordrb::Commands::CommandBot.new token: ENV['TOKEN'].to_s, client_id: ENV['CLIENT_ID'].to_s, prefix: ENV['PREFIX'].to_s

Yt.configure do |config|
  config.api_key = ENV['GOOGLE_API_KEY']
end

bot.command :ping do |msg|
  msg.respond 'pong'
end

bot.command :play do |event, *args|
  video_url = args.join(' ')
  video = Yt::Video.new url: video_url
  stream_url = video.streams.audio.first.url
  event.voice.play_file(stream_url)
end

bot.run
