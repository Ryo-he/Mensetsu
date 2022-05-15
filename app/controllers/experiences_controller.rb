class ExperiencesController < ApplicationController
  def new
    @experience = Experience.new
    @genres = Genre.all
  end

  def index
    @experience = Experience.new
    @keyword = params[:keyword]
   if params[:genres]
    if params[:genres].class == Array
      @genres = params[:genres].join(",")
    else
      @genres = params[:genres]
    end
   end
   if params[:sort].nil? && params[:genres].nil? && params[:keyword].nil?
      @experiences = Experience.page_new(params[:page])
   elsif params[:sort] == 'new'
    if params[:genres] && params[:genres] != ""
      if params[:genres].class == Array
        @experiences = Experience.where(genre_id: params[:genres]).page_new(params[:page])
      else
        @experiences = Experience.where(genre_id: params[:genres].split(",")).page_new(params[:page])
      end
    elsif params[:keyword]
      @experiences = Experience.search(params[:keyword]).page_new(params[:page])
    else
      @experiences = Experience.page_new(params[:page])
    end
   elsif params[:sort] == 'old'
     if params[:genres] && params[:genres] != ""
      if params[:genres].class == Array
        @experiences = Experience.where(genre_id: params[:genres]).page_old(params[:page])
      else
        @experiences = Experience.where(genre_id: params[:genres].split(",")).page_old(params[:page])
      end
     elsif params[:keyword]
      @experiences = Experience.search(params[:keyword]).page_old(params[:page])
     else
      @experiences = Experience.page_old(params[:page])
     end
   elsif params[:sort] == 'favorite'
     if params[:genres] && params[:genres] != ""
      if params[:genres].class == Array
        @experiences = Experience.where(genre_id: params[:genres]).sort_like(params[:page])
      else
        @experiences = Experience.where(genre_id: params[:genres].split(",")).sort_like(params[:page])
      end
     elsif params[:keyword]
       @experiences = Experience.search(params[:keyword]).sort_like(params[:page])
     else
      @experiences = Experience.sort_like(params[:page])
     end
   elsif params[:sort] == "" && params[:genres] == ""
      @experiences = Experience.page_new(params[:page])
   elsif params[:genres]
      if params[:genres] == [""]
       @experiences = Experience.page_new(params[:page])
      else
         @experiences = Experience.where(genre_id: params[:genres]).page_new(params[:page])
      end
   elsif params[:keyword]
      @experiences = Experience.search(params[:keyword]).page_new(params[:page])
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
