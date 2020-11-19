class Customer::ShippingsController < ApplicationController
  def index
    @shipping = Shipping.new
    # @shippings = current_customer.shipping ←NoMethodErrorが出る
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
    @shipping = Shipping.find(params[:id])
  end

  def update
    @shipping = Shipping.find(params[:id])
	  if @shipping.update(shipping_params)
  	 flash[:success] = "配送先を変更しました"
     redirect_to customers_shippings_path
	  else
	   render "edit"
	  end
  end

  def destroy
   @shipping = Shipping.find(params[:id])
	  @shipping.destroy
    @shippings = current_customer.shipping
    flash.now[:alert] = "配送先を削除しました"
	  # redirect_to customers_shipping_addresses_path
  end

  private
  def shipping_params
    params.require(:shipping).permit(:name, :postcode, :address)
  end
end
