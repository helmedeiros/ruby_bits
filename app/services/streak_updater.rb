class StreakUpdater
  def self.touch(user, on: Date.current)
    return unless user
    case user.last_activity_on
    when on               then return
    when on - 1           then user.current_streak += 1
    when nil              then user.current_streak  = 1
    else                       user.current_streak  = 1
    end
    user.longest_streak = [user.longest_streak, user.current_streak].max
    user.last_activity_on = on
    user.save!
  end
end
