require 'spec_helper'

RSpec.describe Track, type: :model do
  it 'requires name and slug' do
    t = Track.new
    expect(t).not_to be_valid
    expect(t.errors[:name]).to be_present
    expect(t.errors[:slug]).to be_present
  end

  it 'normalises slug for URL use' do
    t = Track.new(name: 'Ruby Basics', slug: 'ruby-basics')
    expect(t.to_param).to eq('ruby-basics')
  end
end
