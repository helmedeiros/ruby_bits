class GradingWorker
  include Sidekiq::Worker
  sidekiq_options queue: :grading, retry: 2

  def perform(submission_id)
    submission = Submission.find(submission_id)
    activity   = submission.activity

    result = ActivityChecker.call(activity,
                                  source: submission.source,
                                  choice: submission.choice)

    submission.update!(
      status:     result.status,
      stdout:     result.stdout,
      stderr:     result.stderr,
      runtime_ms: result.runtime_ms
    )

    LessonCompletion.evaluate(submission.user, activity.lesson) if submission.passed?
  end
end
