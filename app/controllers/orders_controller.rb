class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @order_address = OrderAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    @item = Item.find(params[:item_id])
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render action: :index
  end
end

  private
  def order_address_params
    params.permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number, :day_id, :price,:item_id).merge(user_id: current_user.id)
  end

end
