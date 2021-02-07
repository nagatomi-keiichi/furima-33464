class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @item = Item.all.order('id DESC')
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
    redirect_to action: :index unless current_user == @item.user
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def item_params
    params.require(:item).permit(:name, :infomation, :category_id, :state_id, :burden_id, :area_id, :day_id, :price,
                                 :image).merge(user_id: current_user.id)
  end
end
