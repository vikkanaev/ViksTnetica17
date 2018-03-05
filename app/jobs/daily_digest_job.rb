class DailyDigestJob < ApplicationJob
  queue_as :default

  # Запускается через whenever
  def perform
    User.find_each.each do |user|
      DailyMailer.digest(user).deliver_later
    end
  end
end
