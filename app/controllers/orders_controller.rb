class OrdersController < ApplicationController
  before_action :find_item
  def index
    @order_address = OrderAddress.new
  end
  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end
  private
  def find_item
    @item = Item.find(params[:item_id])
  end
  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end
  def pay_item
    Payjp.api_key = "sk_test_110b35149fef1caffaf8abf2"
    Payjp::Charge.create(amount: @item.price, card: order_params[:token], currency: 'jpy')
  end
end