require 'spec_helper'

RSpec.feature 'submitting an activity', type: :feature do
  let(:user) { create(:user, email: 'a@x.test', password: 'p4ssw0rd!', nickname: 'alice') }

  before do
    track = create(:track, slug: 'expressions', name: 'Expressions')
    mod   = create(:learning_module, track: track, slug: 'conditionals', name: 'Conditionals')
    lesson = create(:lesson, learning_module: mod, slug: 'inline-if', title: 'Inline if')
    @activity = create(:activity, lesson: lesson,
                       starter_code: "def add(a,b)\nend\n",
                       solution: "def add(a,b); a+b; end",
                       spec_code: "raise unless add(1,2)==3")
  end

  scenario 'guest is told to sign in' do
    visit track_module_lesson_path('expressions', 'conditionals', 'inline-if')
    expect(page).to have_content 'Inline if'
  end
end
