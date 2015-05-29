class StreakMailer < ActionMailer::Base
  default from: 'no-reply@rubybits.local'

  def about_to_break(user)
    @user = user
    mail to: user.email, subject: "you're about to break a #{user.current_streak}-day streak"
  end
end
