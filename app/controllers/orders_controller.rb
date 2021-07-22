class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :not_move_nil_page
  before_action :find_item
  before_action :not_buy_by_same_user
  before_action :not_buy_sold_item
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
  def not_move_nil_page
    unless Item.find_by id: params[:item_id]
      redirect_to root_path
    end
  end
  def not_buy_by_same_user
    if current_user.id == @item.user_id
      redirect_to root_path
    end    
  end
  def not_buy_sold_item
    if @item.order
      redirect_to root_path
    end
  end
  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end
  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(amount: @item.price, card: order_params[:token], currency: 'jpy')
  end
end