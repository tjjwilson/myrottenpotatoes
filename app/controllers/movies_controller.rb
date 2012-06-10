class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if params[:ratings] then
      @ratings = params[:ratings]
      @select_ratings = params[:ratings].keys
    end
    if params[:sort] == 'title' then
      if @select_ratings != nil then
        @movies = Movie.find_all_by_rating(@select_ratings, :order => 'title')
      else
        @movies = Movie.order('title')
      end
      @mark = 'title'
    elsif params[:sort] == 'release_date' then
      if @select_ratings != nil then
        @movies = Movie.find_all_by_rating(@select_ratings, :order => 'release_date')
      else
        @movies = Movie.order('release_date')
      end
      @mark = 'release_date'
    else
      if @select_ratings != nil then
        @movies = Movie.find_all_by_rating(@select_ratings)
      else
        @movies = Movie.all
      end
      @mark = 'none'
    end
    @all_ratings = Movie.rating_list
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
