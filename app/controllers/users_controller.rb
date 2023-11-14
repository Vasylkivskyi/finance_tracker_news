class UsersController < ApplicationController
  def portfolio
    @user = current_user
    @tracked_stocks = current_user.stocks
  end

  def friends
    @friends = current_user.friends
  end

  def search
    if (params[:friend].present?)
      @friends = User.where("CONCAT(first_name, ' ', last_name) LIKE ?", "%#{params[:friend]}%").where.not(id: current_user.id)
      if !@friends.empty?
        respond_to do |format|
          format.js { render partial: "friends/result" }
        end
      else
        respond_to do |format|
          flash.now[:notice] = "Users not found"
          format.js { render partial: "friends/result" }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a username to search"
        format.js { render partial: "friends/result" }
      end
    end
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end
end
