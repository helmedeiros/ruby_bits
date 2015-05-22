class LessonPresenter
  def initialize(lesson, user = nil)
    @lesson, @user = lesson, user
  end

  def title;   @lesson.title; end
  def slug;    @lesson.slug; end
  def body;    @lesson.body; end
  def track;   @lesson.learning_module.track; end
  def mod;     @lesson.learning_module; end
  def activities; @lesson.activities; end

  def status_glyph
    return '○' unless @user
    @user.completed?(@lesson) ? '●' : '◐'
  end

  def progress
    return 0 unless @user
    total = activities.size
    return 0 if total.zero?
    done = @user.submissions
                .where(activity_id: activities.map(&:id), status: 'passed')
                .distinct.pluck(:activity_id).size
    ((done.to_f / total) * 100).round
  end
end
