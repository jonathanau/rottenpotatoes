class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.get_all_ratings
    session[:ratings] ||= @all_ratings
    ratings = params[:ratings].nil? ? session[:ratings] : params[:ratings].keys
    order = params[:order].nil? ? session[:order] : params[:order]
    @movies = Movie.where('rating in (?)', ratings).order(order)

    @hilite = order

    session[:ratings] = ratings
    session[:order] = order
    flash[:notice] = {
      :params => params,
      :session_ratings => session[:ratings],
      :session_order => session[:order],
    }
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
