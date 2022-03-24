FactoryBot.define do
  factory :reservation do
    sequence(:code){|x| "CODE-#{x}" }
    status {'accepted'}
    number_of_guests {1}
    start_date {Date.today}
    end_date {Date.today + 2.day}
    number_of_nights {2}
    number_of_adults {1}
    number_of_children {0}
    number_of_infants {0}
    currency {'aud'}
    payout_price {500}
    security_price {500}
    total_price {1000}

    association :guest, factory: :guest
  end
end