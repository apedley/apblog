require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.sequence(:name) { |n| "foo#{n}" }
    f.sequence(:email) { |n| "foo#{n}@example.com" }
    f.password "secret"
  end

  factory :post do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    published true
    published_at Time.now
    association :user
  end
end