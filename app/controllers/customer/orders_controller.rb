class Customer::OrdersController < ApplicationController
     include ApplicationHelper

  before_action :to_confilm, only: [:show]
  before_action :authenticate_customer!

  def new
  	@order = Order.new
  	@shipping = Shipping.where(customer: current_customer)
  end

	def confilm
    @cart_items = current_cart
		@order = Order.new(
      customer: current_customer,
      payment_method: params[:order][:payment_method]
    )

    # total_priceに請求額を代入
    @order.price = billing(@order)

    # addressにresidenceの値がはいっていれば
    if params[:order][:addresses] == "residence"
      @order.postcode = current_customer.postcode
      @order.address     = current_customer.residence
      @order.name        = current_customer.last_name +
                           current_customer.first_name

    # addressにshipping_addressesの値がはいっていれば
    elsif params[:order][:addresses] == "shipping"
      ship = Shipping.find(params[:order][:shipping_id])
      @order.postcode = ship.postcode
      @order.address     = ship.address
      @order.name        = ship.name

    # addressにnew_addressの値がはいっていれば
    elsif params[:order][:addresses] == "new_address"
      @order.postcode = params[:order][:postcode]
      @order.address     = params[:order][:address]
      @order.name        = params[:order][:name]
      @ship = "1"

      # バリデーションがあるならエラーメッセージを表示
      unless @order.valid? == true
        @shipping = Shipping.where(customer: current_customer)
        render :new
      end
    end
	end

	def create
    @order = current_customer.orders.new(order_params)
    @order.save
    flash[:notice] = "ご注文が確定しました。"
    redirect_to complete_customers_orders_path

    # もし情報入力でnew_addressの場合ShippingAddressに保存
    if params[:order][:ship] == "1"
      current_customer.shipping.create(address_params)
    end

    # カート商品の情報を注文商品に移動
    @cart_items = current_cart
    @cart_items.each do |cart_item|
    OrderDetail.create(
      product:  cart_item.product,
      order:    @order,
      quantity: cart_item.quantity,
      subprice: sub_price(cart_item)
    )
    end
    # 注文完了後、カート商品を空にする
    @cart_items.destroy_all
	end

	def complete
	end

	def index
    @orders = current_customer.orders
	end

	def show
	  @order = Order.find(params[:id])
    @order_details = @order.order_details
	end

  private

  def order_params
    params.require(:order).permit(:postcode, :address, :name, :payment_method, :price)
  end

  def address_params
    params.require(:order).permit(:postcode, :address, :name)
  end

  def to_confilm
    redirect_to customers_cart_items_path if params[:id] == "confilm"
  end
end
