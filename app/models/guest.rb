class Guest < ApplicationRecord

  field :email, type: String

  validates :email, presence: true
end
