require 'spec_helper'

RSpec.describe Lesson, type: :model do
  it 'belongs to a learning module' do
    expect(described_class.reflect_on_association(:learning_module).macro).to eq(:belongs_to)
  end

  it 'has many activities and comments' do
    expect(described_class.reflect_on_association(:activities).macro).to eq(:has_many)
    expect(described_class.reflect_on_association(:comments).macro).to eq(:has_many)
  end

  it 'delegates track to its learning module' do
    track  = build_stubbed(:track)
    mod    = build_stubbed(:learning_module, track: track)
    lesson = build_stubbed(:lesson, learning_module: mod)
    expect(lesson.track).to eq(track)
  end

  it 'orders prev/next by position within the module' do
    mod = create(:learning_module)
    a   = create(:lesson, learning_module: mod, position: 0, slug: 'a')
    b   = create(:lesson, learning_module: mod, position: 1, slug: 'b')
    c   = create(:lesson, learning_module: mod, position: 2, slug: 'c')

    expect(b.previous).to eq(a)
    expect(b.next).to     eq(c)
    expect(a.previous).to be_nil
    expect(c.next).to     be_nil
  end
end
