FactoryGirl.define do
  factory :lesson do
    learning_module
    sequence(:title) { |n| "Lesson #{n}" }
    sequence(:slug)  { |n| "lesson-#{n}" }
    body 'Some markdown body.'
  end
end
