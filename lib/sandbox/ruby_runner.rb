require 'open3'
require 'tempfile'

module Sandbox
  # Runs user-submitted Ruby in a subprocess so syntax errors and crashes
  # are isolated from the Rails app. Uses --disable=gems and a wall-clock
  # timeout. NOT a real security sandbox — pair with seccomp/docker in prod.
  class RubyRunner
    TIMEOUT_SECONDS = 5

    Result = Struct.new(:status, :stdout, :stderr, :runtime_ms)

    def initialize(source, spec_code = nil)
      @source = source.to_s
      @spec   = spec_code.to_s
    end

    def run
      script = "#{@source}\n#{@spec}\n"
      Tempfile.create(['rb_submission', '.rb']) do |f|
        f.write(script)
        f.flush
        execute(f.path)
      end
    end

    private

    def execute(path)
      started = Time.now
      stdout, stderr, status = nil, nil, nil
      begin
        Timeout.timeout(TIMEOUT_SECONDS) do
          stdout, stderr, status = Open3.capture3('ruby', '--disable=gems', path)
        end
      rescue Timeout::Error
        return Result.new('error', '', "timeout after #{TIMEOUT_SECONDS}s", elapsed(started))
      end
      passed = status.success?
      Result.new(passed ? 'passed' : 'failed', stdout, stderr, elapsed(started))
    end

    def elapsed(t)
      ((Time.now - t) * 1000).round(2)
    end
  end
end
