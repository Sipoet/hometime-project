class Reservation < ApplicationRecord

  validates :code, presence: true, uniqueness: true
end
