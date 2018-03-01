class DailyDigestJob < ApplicationJob
  queue_as :default

  # Запускается через whenever
  def perform
    User.send_daily_digest
  end
end
