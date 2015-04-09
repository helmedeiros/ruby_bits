FactoryGirl.define do
  factory :activity do
    lesson
    sequence(:title) { |n| "Activity #{n}" }
    kind 'code'
    prompt 'Make it pass.'
    starter_code "def add(a, b)\nend\n"
    solution    "def add(a, b)\n  a + b\nend\n"
    spec_code   "raise unless add(1,2) == 3\n"
  end
end
