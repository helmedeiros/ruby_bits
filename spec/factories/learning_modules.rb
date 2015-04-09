FactoryGirl.define do
  factory :learning_module do
    track
    sequence(:name) { |n| "Module #{n}" }
    sequence(:slug) { |n| "module-#{n}" }
  end
end
