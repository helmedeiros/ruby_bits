class ActivityResultPresenter
  GLYPH = { 'passed' => '✓', 'failed' => '✗', 'error' => '!', 'pending' => '…' }.freeze

  def initialize(result)
    @result = result
  end

  def glyph;  GLYPH.fetch(@result.status, '?'); end
  def class_name; "result-#{@result.status}"; end
  def runtime;   @result.runtime_ms ? "#{@result.runtime_ms}ms" : nil; end
end
