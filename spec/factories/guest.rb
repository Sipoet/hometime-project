FactoryBot.define do
  factory :guest do
    sequence(:email){|x| "email-#{x}@hometime.com" }
    sequence(:first_name){|x| "first_name-#{x}" }
    sequence(:last_name){|x| "last_name-#{x}" }
  end
end