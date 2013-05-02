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
    sequence(:preview) { |n| "preview for post #{n}"}
    published true
    published_at Time.now
    user
  end
end