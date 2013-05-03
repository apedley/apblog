require 'faker'

FactoryGirl.define do
  
  factory :user do
    sequence :name do |n|
      "foo#{n}"
    end
    sequence :email do |n|
      "foo#{n}@example.com"
    end
    password "secret"
    admin false
  end


  factory :post do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    published true
    user

    
  end
end