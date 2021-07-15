class ItemsController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
    @items = Item.order("created_at DESC")
  end
  def new
    @item = Item.new
  end
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end
  def show
    @item = Item.find(params[:id])
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :description, :genre_id, :status_id, :delivery_charge_id, :prefecture_id, :shipping_day_id, :price).merge(user_id: current_user.id)
  end
end
