class Shipping < ApplicationRecord
  belongs_to :customer

  validates :customer_id, :name, :address, presence: true
	validates :postcode, length: {is: 7},  numericality: { only_integer: true } #整数のみ可
end
