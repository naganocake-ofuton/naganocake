class Item < ApplicationRecord
    belongs_to :genre
	has_many :cart_items
	has_many :orders, through: :order_details
	has_many :order_items

	attachment :image

	validates :genre_id, :name, :tax_out_price, presence: true
	validates :explanation, length: {maximum: 200}
	validates :tax_out_price, numericality: { only_integer: true }
end
