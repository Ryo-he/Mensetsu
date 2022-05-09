class ExperiencesController < ApplicationController
  def new
    @experience = Experience.new
    @genres = Genre.all
  end

  def index
    @experience = Experience.new
    @experiences = Experience.page(params[:page]).order(created_at: :DESC)
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

  def search
    if params[:sort] == 'new'
      @experiences = Experience.page(params[:page]).order(created_at: :DESC)
    elsif params[:sort] == 'old'
      @experiences = Experience.page(params[:page]).order(created_at: :ASC)
    elsif params[:sort] == 'favorite'
      @experiences = Experience.sort_like.paginate(page: params[:page],per_page: (10))
    elsif params[:sort] == ""
      @experiences = Experience.page(params[:page]).order(created_at: :DESC)
    end
  end

  def company_search
    @experiences = Experience.search(params[:keyword]).page(params[:page]).order(created_at: :DESC)
    @keyword = params[:keyword]
    render "index"
  end

  def genre_search
    if params[:genres] == [""]
       @experiences = Experience.page(params[:page]).order(created_at: :DESC)
    else
       @experiences = Experience.where(genre_id: params[:genres]).page(params[:page]).order(created_at: :DESC)
    end
    render "index"
  end

private

  def experience_params
    params.require(:experience).permit(:genre_id, :title, :name, :situation, :time, :format, :atomosphere, :question, :impression)
  end

end
