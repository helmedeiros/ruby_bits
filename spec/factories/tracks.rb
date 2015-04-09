FactoryGirl.define do
  factory :track do
    sequence(:name) { |n| "Track #{n}" }
    sequence(:slug) { |n| "track-#{n}" }
  end
end
