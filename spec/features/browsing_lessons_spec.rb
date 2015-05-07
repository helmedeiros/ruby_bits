require 'spec_helper'

RSpec.feature 'browsing lessons', type: :feature do
  before do
    track   = create(:track, name: 'Expressions', slug: 'expressions')
    mod     = create(:learning_module, track: track, name: 'Conditionals', slug: 'conditionals')
    @lesson = create(:lesson, learning_module: mod, title: 'Inline if', slug: 'inline-if',
                              body: '## Inline if\nUse it for guard clauses.')
  end

  scenario 'guest visits a lesson' do
    visit track_module_lesson_path('expressions', 'conditionals', 'inline-if')
    expect(page).to have_content 'Inline if'
    expect(page).to have_content 'guard clauses'
    expect(page).to have_link 'Expressions'
  end
end
