class ItemsController < ApplicationController

respond_to :html, :js

  def create
    @user = User.find(params[:user_id])
    @item = @user.items.build(item_params)
    if @item.save
      flash[:notice] = "Item was saved."
      redirect_to [@user]
    else
      flash.now[:alert] = "There was an error saving the item. Please try again."
      render @user
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @item = @user.items.find(params[:id])
    if @item.delete
      flash[:notice] = "Item was deleted."
    else
      flash.now[:alert] = "There was an error deleting the item. Please try again."
    end
    respond_to do |format|
         format.html
         format.js
    end
  end

  private

  def item_params
    params.require(:item).permit(:name)
  end

end
