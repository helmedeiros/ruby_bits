require 'sandbox/ruby_runner'

class ActivityChecker
  Result = Struct.new(:status, :stdout, :stderr, :runtime_ms, :hint)

  def self.call(activity, payload)
    new(activity, payload).call
  end

  def initialize(activity, payload)
    @activity = activity
    @payload  = payload
  end

  def call
    case @activity.kind
    when 'code'   then check_code
    when 'choice' then check_choice
    else
      Result.new('error', '', "unknown kind: #{@activity.kind}", 0, nil)
    end
  end

  private

  def check_code
    res = Sandbox::RubyRunner.new(@payload[:source], @activity.spec_code).run
    Result.new(res.status, res.stdout, res.stderr, res.runtime_ms, hint_for(res))
  end

  def check_choice
    correct = @payload[:choice].to_s == @activity.correct_choice.to_s
    Result.new(correct ? 'passed' : 'failed', '', '', 0, correct ? nil : 'try again — re-read the prompt')
  end

  def hint_for(res)
    return nil if res.status == 'passed'
    return 'syntax error — check your braces and ends' if res.stderr.to_s =~ /syntax|unexpected/i
    'check your return values'
  end
end
