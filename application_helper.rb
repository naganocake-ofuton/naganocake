module ApplicationHelper
  def current_cart
    @cart_items = current_customer.cart_items
  end

  # 小数点切り捨てはfloor,３桁区切りはto_s(:delimited)
  # 税込の計算
  def tax_price(price)
    (price * 1.1).floor
  end

  # 小計の計算
  def sub_price(sub)
    (tax_price(sub.item.price) * sub.amount)
  end

  # 合計金額の計算
  def pay_amount(totals)
    price = 0
    totals.each do |total|
      price  +=  sub_price(total)
    end
    return price
  end

  # 請求額の計算
  def billing(order)
    pay_amount(current_cart) + order.postage
  end

  def full_title(title = "")
    base_title = "NaganoCAKE"
		if admin_signed_in?
			base_title + "|" + "(管理者) #{title}"
		else
			base_title + "|" + "#{title}"
		end
  end

	def full_name(customer)
		customer.last_name + customer.first_name
	end

	def full_name_kana(customer)
		customer.last_name_kana+customer.first_name_kana
	end

  def full_address(key)
		  "#{key.postcode} #{key.address}"
  end

end
