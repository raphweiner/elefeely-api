require 'pusher'

Pusher.app_id = 45824
Pusher.key = '04a0ef97e7f6ccaab599'
Pusher.secret = ENV['PUSHER_SECRET']
Pusher.logger = Rails.logger
