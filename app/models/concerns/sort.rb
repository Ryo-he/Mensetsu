module Sort
 extend ActiveSupport::Concern

 included do 
  
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
 end
end