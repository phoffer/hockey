require 'clockwork'
require_relative './config/boot'
require_relative './config/environment'

module Clockwork
  LIVE_INTERVAL = 30.seconds
  SCHEDULE_INTERVAL = 8.hours
  handler do |job|
    puts "Running #{job}"
  end

  # handler receives the time when job is prepared to run in the 2nd argument
  # handler do |job, time|
  #   puts "Running #{job}, at #{time}"
  # end

  every(SCHEDULE_INTERVAL, 'sync.daily_schedule') { Game.import_daily_schedule }
  every(LIVE_INTERVAL, 'sync.live_games') { Game.sync_live_games }
  # every(3.minutes, 'less.frequent.job')

  # every(1.day, 'midnight.job', :at => '00:00')
end
