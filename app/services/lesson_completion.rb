class LessonCompletion
  def self.evaluate(user, lesson)
    return unless user && lesson
    required = lesson.activities.pluck(:id)
    return if required.empty?
    passed = user.submissions
                 .where(activity_id: required, status: 'passed')
                 .distinct.pluck(:activity_id)
    if (required - passed).empty?
      Completion.find_or_create_by!(user: user, lesson: lesson) do |c|
        c.completed_at = Time.current
      end
    end
  end
end
