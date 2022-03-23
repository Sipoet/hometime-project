FactoryBot.define do
  factory :reservation do
    sequence(:code){|x| "CODE-#{x}" }

  end
end