require 'rails_helper'

RSpec.describe "Reservations Management", type: :request do
  let(:path){'/reservations'}
  let(:headers){ {'Content-Type' => 'application/json'} }
  let(:reservation_code){'YYY12345678'}
  let(:reservation_status){"accepted"}
  let(:number_of_guests){4}
  let(:guest_first_name){'Wayne'}
  let(:guest_last_name){'Woodbridge'}
  let(:guest_email){'wayne_woodbridge@bnb.com'}

  let(:list_sample) { [
      {
        "reservation_code": reservation_code,
        "start_date": "2021-04-14",
        "end_date": "2021-04-18",
        "nights": 4,
        "guests": number_of_guests,
        "adults": 2,
        "children": 2,
        "infants": 0,
        "status": reservation_status,
        "guest": {
          "first_name": guest_first_name,
          "last_name": guest_last_name,
          "phone": "639123456789",
          "email": guest_email
        },
        "currency": "AUD",
        "payout_price": "4200.00",
        "security_price": "500",
        "total_price": "4700.00"
      },


      {
        "reservation": {
          "code": reservation_code,
          "start_date": "2021-03-12",
          "end_date": "2021-03-16",
          "expected_payout_amount": "3800.00",
          "guest_details": {
            "localized_description": "4 guests",
            "number_of_adults": 2,
            "number_of_children": 2,
            "number_of_infants": 0
          },
          "guest_email": guest_email,
          "guest_first_name": guest_first_name,
          "guest_last_name": guest_last_name,
          "guest_phone_numbers": [
            "639123456789",
            "639123456789"
          ],
          "listing_security_price_accurate": "500.00",
          "host_currency": "AUD",
          "nights": 4,
          "number_of_guests": number_of_guests,
          "status_type": reservation_status,
          "total_paid_amount_accurate": "4300.00"
        }
      }
    ]
  }

  describe "POST /reservations" do
    2.times do |x|
      describe "sample #{x + 1}" do
        let(:body_params){list_sample[x]}
        context 'reservation' do
          it 'create reservation' do
            post path, params: body_params.to_json, headers: headers
            expect(response.code).to eq('200')
            reservation = Reservation.find_by(code: reservation_code)
            expect(reservation).to be_present
            expect(reservation.code).to eq(reservation_code)
            expect(reservation.status).to eq(reservation_status)
          end

          it 'code must uniq' do
            post path, params: body_params.to_json, headers: headers
            post path, params: body_params.to_json, headers: headers
            expect(Reservation.all.count).to eq(1)
          end

          it 'update reservation' do
            reservation = create :reservation, code: reservation_code, status: 'failed'
            post path, params: body_params.to_json, headers: headers
            expect(response.code).to eq('200')
            reservation.reload
            expect(reservation.code).to eq(reservation_code)
            expect(reservation.status).to eq(reservation_status)
          end
        end

        context  'guest' do
          it 'create guest' do
            post path, params: body_params.to_json, headers: headers
            expect(response.code).to eq('200')
            guest = Guest.find_by(email: guest_email)
            expect(guest).to be_present
            expect(guest.email).to eq(guest_email)
          end

          it 'email must uniq' do
            post path, params: body_params.to_json, headers: headers
            post path, params: body_params.to_json, headers: headers
            expect(Guest.all.count).to eq(1)
          end

          it 'update guest' do
            guest = create :guest, email: guest_email, first_name: 'Woody', last_name: 'Woodpecker'
            post path, params: body_params.to_json, headers: headers
            expect(response.code).to eq('200')
            guest.reload
            expect(guest.email).to eq(guest_email)
            expect(guest.first_name).to eq(guest_first_name)
            expect(guest.last_name).to eq(guest_last_name)
          end
        end
      end

    end
  end
end
