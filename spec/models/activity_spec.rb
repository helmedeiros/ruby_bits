require 'spec_helper'

RSpec.describe Activity, type: :model do
  it 'rejects unknown kinds' do
    a = build(:activity, kind: 'whatever')
    expect(a).not_to be_valid
  end

  it 'serialises choices as a Hash' do
    a = create(:activity, kind: 'choice', choices: { 'a' => 'A', 'b' => 'B' })
    expect(a.reload.choices).to eq('a' => 'A', 'b' => 'B')
  end

  it 'identifies its kind' do
    expect(build(:activity, kind: 'code')).to be_code
    expect(build(:activity, kind: 'choice')).to be_choice
  end
end
