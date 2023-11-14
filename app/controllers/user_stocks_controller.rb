class UserStocksController < ApplicationController
  def create
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio"
    redirect_to request.referrer
  end

  def destroy
    user_stock = UserStock.where(user_id: current_user.id, stock_id: params[:id]).first
    if user_stock.destroy
      flash[:success] = "#{user_stock.stock.ticker} stock was successfully removed from portfolio"
      redirect_to request.referrer
    end
  end
end
