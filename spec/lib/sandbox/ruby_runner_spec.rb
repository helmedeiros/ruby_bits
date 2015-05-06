require 'spec_helper'
require 'sandbox/ruby_runner'

RSpec.describe Sandbox::RubyRunner do
  it 'passes when the spec assertions hold' do
    res = described_class.new("def add(a,b); a+b; end", "raise unless add(1,2)==3").run
    expect(res.status).to eq('passed')
  end

  it 'fails when the spec raises' do
    res = described_class.new("def add(a,b); a-b; end", "raise unless add(1,2)==3").run
    expect(res.status).to eq('failed')
    expect(res.stderr).to match(/RuntimeError|raise/)
  end

  it 'reports timeout as an error' do
    res = described_class.new("loop { sleep 0.1 }", "").run
    expect(res.status).to eq('error')
    expect(res.stderr).to match(/timeout/)
  end
end
