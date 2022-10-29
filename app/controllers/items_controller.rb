class ItemsController < ApplicationController
  

  def index
      user = User.find_by(id: params[:user_id])
      users = User.all
    if user
      items = user.items
      render json: items, include: :user, status: :not_found
    elsif params[:user_id]
      render json: {error: 'User not found'}, status: :not_found
    else
      items = Item.all
      render json: items, include: :user, status: :ok
    end
  rescue
    render json: {error: 'Items not found.'}, status: :not_found
  end

  def show
    user = User.find(params[:user_id])
    user_item = user.items.find(params[:id])
    render json: user_item, include: :user, status: :ok
  rescue
    render json: {error: 'User item not found'}, status: :not_found
  end

  def create
    user = User.find(params[:user_id])
    item = user.items.create(item_params)
    render json: item, status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price)
  end

end
