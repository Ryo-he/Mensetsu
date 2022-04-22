class ExperiencesController < ApplicationController
  def new
    @experience = Experience.new
    @genres = Genre.all
  end

  def index
    @experience = Experience.new
    @experiences = Experience.all
    @genres = Genre.all
  end

  def create
    @experience = Experience.new(experience_params)
    @experience.user_id = current_user.id
   if @experience.save
      redirect_to experience_path(@experience.id)
   else
      @genres = Genre.all
      @experiences = Experience.all
      render :new
   end
  end

  def show
    @experience = Experience.find(params[:id])
  end

  def edit
    @experience = Experience.find(params[:id])
    @genres = Genre.all
  end

  def update
    @experience = Experience.find(params[:id])
  if @experience.update(experience_params)
    redirect_to experience_path(@experience.id)
  else
    @genres = Genre.all
    render :edit
  end
  end

  def destroy
    @experience = Experience.find(params[:id])
    @experience.destroy
    redirect_to request.referer
  end

private

  def experience_params
    params.require(:experience).permit(:genre_id, :title, :name, :situation, :time, :format, :atomosphere, :question, :impression)
  end

end
