class FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @experience = Experience.find(params[:experience_id])
    favorite = @experience.favorites.new(user_id: current_user.id)
   if favorite.save
     redirect_to request.referer
   else
     redirect_to request.referer
   end
  end
  
  def destroy
     @experience = Experience.find(params[:experience_id])
     favorite = @experience.favorites.find_by(user_id: current_user.id)
   if favorite.present?
     favorite.destroy
     redirect_to request.referer
   else
     redirect_to request.referer
   end
  end
end
