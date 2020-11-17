class Customer::ShippingsController < ApplicationController
  def index
    @shipping = Shipping.new
    @shippings = current_customer.shipping
  end

  def create
    @shipping = Shipping.new(shipping_params)
    @shipping.customer_id = current_customer.id
    if @shipping.save
      flash[:notice] = 'You have created shipping address successfully'
      redirect_to request.referer
    else
       @shipping = Shipping.new
       @shippings = current_customer.shipping
      render :index
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def shipping_params
    params.require(:shipping).permit(:name, :postcode, :address)
  end
end
