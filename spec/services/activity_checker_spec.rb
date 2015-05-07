require 'spec_helper'

RSpec.describe ActivityChecker do
  describe 'choice activities' do
    let(:activity) { build_stubbed(:activity, kind: 'choice', correct_choice: 'b') }

    it 'passes the correct choice' do
      res = described_class.call(activity, choice: 'b')
      expect(res.status).to eq('passed')
    end

    it 'fails the wrong choice with a hint' do
      res = described_class.call(activity, choice: 'a')
      expect(res.status).to eq('failed')
      expect(res.hint).to be_present
    end
  end

  describe 'code activities' do
    let(:activity) do
      build_stubbed(:activity, kind: 'code', spec_code: "raise unless add(1,2)==3")
    end

    it 'delegates to RubyRunner and bubbles status' do
      res = described_class.call(activity, source: "def add(a,b); a+b; end")
      expect(res.status).to eq('passed')
    end
  end
end
