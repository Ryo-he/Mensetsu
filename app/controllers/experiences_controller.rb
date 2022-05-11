class ExperiencesController < ApplicationController
  def new
    @experience = Experience.new
    @genres = Genre.all
  end

  def index
    @experience = Experience.new
    @experiences = Experience.page(params[:page])
    @genres = Genre.all
    if params[:sort] == 'new'
      @experiences = Experience.page(params[:page]).order(created_at: :DESC)
    elsif params[:sort] == 'old'
      @experiences = Experience.page(params[:page]).order(created_at: :ASC)
    elsif params[:sort] == 'favorite'
      @experiences = Experience.sort_like.paginate(page: params[:page],per_page: (2))
    elsif params[:sort] == ""
      @experiences = Experience.page(params[:page]).order(created_at: :DESC)
    elsif params[:genres] == [""]
      @experiences = Experience.page(params[:page]).order(created_at: :DESC)
    elsif
      @experiences = Experience.where(genre_id: params[:genres]).paginate(page: params[:page],per_page: (2)).order(created_at: :DESC)
    elsif
      @experiences = Experience.search(params[:keyword]).order(created_at: :DESC).page(params[:page])
      @keyword = params[:keyword]
    end
  end

  def create
    @experience = Experience.new(experience_params)
    @experience.user_id = current_user.id
   if @experience.save
      redirect_to experience_path(@experience.id)
   else
      @genres = Genre.all
      @experiences = Experience.all
      render "new"
   end
  end

  def show
    @experience = Experience.find(params[:id])
    @comment = Comment.new
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
    render "edit"
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
