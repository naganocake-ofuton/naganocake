class Customer::ShippingsController < ApplicationController
  def index
    @shipping = Shipping.new
    @shippings = Shipping.all
  end

  def create
    @shipping = Shipping.new(shipping_params)
    @shipping.save
    redirect_to request.referer
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
