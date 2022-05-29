require 'discordrb'
require 'dotenv'
require 'pry'

Dotenv.load('.env')

bot = Discordrb::Commands::CommandBot.new token: ENV['TOKEN'].to_s, client_id: ENV['CLIENT_ID'].to_s, prefix: ENV['PREFIX'].to_s

bot.command :ping do |msg|
  msg.respond 'aaaaaaaaaa'
end

bot.command :fideliz do |msg|
  msg.respond 'corno broxa calvo careca corno manso gay boiola viado'
end

bot.command :play do |event|
  channel = event.user.voice_channel

  next 'Você não está conectado em nenhum canal de voz ;(' unless channel

  bot.voice_connect(channel)
  voice_bot = event.voice
  voice_bot.play_file('tmp/musica.mp3')
end

bot.command :stop do |event|
  voice_bot = event.voice
  voice_bot.stop_playing
  voice_bot.destroy

  msg.respond ''
end

bot.command :pause do |event|
  voice_bot = event.voice
  voice_bot.pause

  msg.respond ''
end

bot.command :resume do |event|
  voice_bot = event.voice
  voice_bot.continue

  msg.respond ''
end

bot.run
