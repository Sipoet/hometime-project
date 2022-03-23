FactoryBot.define do
  factory :guest do
    sequence(:email){|x| "email-#{x}@hometime.com" }

  end
end