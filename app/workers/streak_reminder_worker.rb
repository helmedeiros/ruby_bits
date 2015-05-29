class StreakReminderWorker
  include Sidekiq::Worker
  sidekiq_options queue: :mail

  def perform
    User.where('current_streak >= ?', 2)
        .where(last_activity_on: Date.yesterday)
        .find_each do |u|
      StreakMailer.about_to_break(u).deliver_later
    end
  end
end
