class Order < ApplicationRecord
  belongs_to :customer
	has_many :order_items, dependent: :destroy

	enum payment_method:[:クレジットカード, :銀行振り込み]
	enum status:[:入金待ち, :入金確認, :製作中, :発送準備中, :発送済み]

end
