# frozen_string_literal: true

require 'discordrb'
require 'dotenv'
require 'pry'
require 'open3'
require 'youtube-dl.rb'

Dotenv.load('.env')

bot = Discordrb::Commands::CommandBot.new token: ENV['TOKEN'].to_s, client_id: ENV['CLIENT_ID'].to_s, prefix: ENV['PREFIX'].to_s

bot.command :ping do |msg|
  msg.respond 'pong'
end

bot.command :play do |event, url|
  # Download the video using youtube-dl
  video = YoutubeDL.download(url)

  # Use ffmpeg to stream the video to the voice channel
  Open3.popen3("ffmpeg -i #{video.path} -ac 2 -f s16le -ar 48000 pipe:1") do |stdin, stdout, _|
    bot.voice_connect(event.user.voice_channel)
    bot.voice_play(stdout)
  end
end

bot.run
