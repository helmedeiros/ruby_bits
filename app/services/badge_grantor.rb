class BadgeGrantor
  RULES = {
    'first-blood' => ->(u) { u.completions.count >= 1 },
    'streak-3'    => ->(u) { u.current_streak  >= 3 },
    'streak-7'    => ->(u) { u.current_streak  >= 7 },
    'centurion'   => ->(u) { u.submissions.where(status: 'passed').count >= 100 },
  }.freeze

  def self.evaluate(user)
    return unless user
    RULES.each do |slug, rule|
      next unless rule.call(user)
      badge = Badge.find_by(slug: slug)
      next unless badge
      Award.find_or_create_by!(user: user, badge: badge) { |a| a.awarded_at = Time.current }
    end
  end
end
