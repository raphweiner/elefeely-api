require 'pusher'

Pusher.app_id = 45807
Pusher.key = 'e77c412e7c11274b627a'
Pusher.secret = ENV['PUSHER_SECRET']
Pusher.logger = Rails.logger
