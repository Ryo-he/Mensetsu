class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @experiences = Experience.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
  if @user.update(user_params)
    redirect_to user_path(@user.id)
  else
    render :edit
  end
    
  end

  def unsubscribe
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end
  
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :image)
  end
end
