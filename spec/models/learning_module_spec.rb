require 'spec_helper'

RSpec.describe LearningModule, type: :model do
  it 'belongs to a track' do
    assoc = LearningModule.reflect_on_association(:track)
    expect(assoc.macro).to eq(:belongs_to)
  end

  it 'has many lessons' do
    assoc = LearningModule.reflect_on_association(:lessons)
    expect(assoc.macro).to eq(:has_many)
  end
end
