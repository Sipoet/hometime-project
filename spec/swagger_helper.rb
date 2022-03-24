# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      components: {
        schemas: {
          reservations:{
            sample1:{
              type: 'object',
              properties:{
                reservation_code: {type: :string},
                start_date: {type: :string},
                end_date: {type: :string},
                nights: {type: :number},
                guests: {type: :number},
                adults: {type: :number},
                children: {type: :number},
                infants: {type: :number},
                status: {type: :string},
                guest: {
                  type: 'object',
                  properties:{
                    first_name: {type: :string},
                    last_name: {type: :string},
                    phone: {type: :string},
                    email: {type: :string}
                  }
                },
                currency: {type: :string},
                payout_price: {type: :string},
                security_price: {type: :string},
                total_price: {type: :string}
              }
            },
            sample2:{
              type: 'object',
              properties:{
                reservation: {
                  type: 'object',
                  properties:{
                    code: {type: :string},
                    start_date: {type: :string},
                    end_date: {type: :string},
                    expected_payout_amount: {type: :string},
                    guest_details: {
                      type: 'object',
                      properties: {
                        localized_description: {type: :string},
                        number_of_adults: {type: :number},
                        number_of_children: {type: :number},
                        number_of_infants: {type: :number}
                      }
                    },
                    guest_email: {type: :string},
                    guest_first_name: {type: :string},
                    guest_last_name: {type: :string},
                    guest_phone_numbers: {
                      type: :array,
                      items:{
                        type: :string
                      }
                    },
                    listing_security_price_accurate: {type: :string},
                    host_currency: {type: :string},
                    nights: {type: :number},
                    number_of_guests: {type: :number},
                    status_type: {type: :string},
                    total_paid_amount_accurate: {type: :string}
                  }
                }
              }
            },
          }
        }
      },
      paths: {},
      servers: [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'www.example.com'
            }
          }
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
