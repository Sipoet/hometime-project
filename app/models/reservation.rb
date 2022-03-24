class Reservation < ApplicationRecord

  validates :code, presence: true, uniqueness: true

  belongs_to :guest
end
