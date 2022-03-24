require 'swagger_helper'

RSpec.describe 'reservations', type: :request do
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

  path '/reservations' do
    #  post('create_or_update reservation') do
    #   tags 'reservation'
    #   consumes 'application/json'
    #   parameter name: :blog, in: :body, schema: {
    #     type: :object,
    #     properties: {
    #       title: { type: :string },
    #       content: { type: :string }
    #     },
    #     required: [ 'title', 'content' ]
    #   }

    #   response '201', 'blog created' do
    #     let(:blog) { { title: 'foo', content: 'bar' } }
    #     run_test!
    #   end

    #   response '422', 'invalid request' do
    #     let(:blog) { { title: 'foo' } }
    #     run_test!
    #   end
    # end

    post('create or update reservation') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :reservation, in: :body, schema: {
        oneOf: [
          { '$ref' => '#/components/schemas/reservations/sample1' },
          { '$ref' => '#/components/schemas/reservations/sample2' }
        ]
      }

      response(200, 'successful') do
        schema type: :object,
          properties: {
            data: {
              type: :object,
              properties:{
                id: {type: :string}
              }
            },
            message: { type: :string }
          }


        # after do |example|
        #   example.metadata[:response][:content] = {
        #     'application/json' => {
        #       example: JSON.parse(response.body, symbolize_names: true)
        #     }
        #   }
        # end
        run_test! do |response|
          expect(response.code).to eq('200')
          json_body = JSON.parse(response.body)
          expect(json_body).to be_present
          data = json_body['data']
          expect(data).to be_present
          reservation = Reservation.all
                                   .order(update_at: :desc)
                                   .first
          expect(data['id']).to eq(reservation.id)
        end
      end
    end
  end
end
