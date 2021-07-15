class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :not_move_nil_page, only: [:show, :edit]
  before_action :not_edit_by_other_user, only: [:edit, :update]
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
  def edit
    @item = Item.find(params[:id])
  end
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :description, :genre_id, :status_id, :delivery_charge_id, :prefecture_id, :shipping_day_id, :price).merge(user_id: current_user.id)
  end
  def not_move_nil_page
    unless Item.find_by id: params[:id]
      redirect_to root_path
    end
  end
  def not_edit_by_other_user
    unless current_user.id == Item.find(params[:id]).user_id
      redirect_to root_path
    end
  end
end
