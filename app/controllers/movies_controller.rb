# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
  def index
    #ambos nao funcionam juntos pq o sort_by é um link, não um filtro (checkbox)
    #o sort teria que ser aplicado aos filmes do ultimo retorno
    @all_ratings = Movie.all_ratings
    @selected_ratings = params[:ratings]&.keys || @all_ratings
    @sort_column = params[:sort_by]
    if params[:ratings]
      @movies = Movie.where(rating: @selected_ratings)
      if @sort_column
        @movies = @movies.order(@sort_column)
      end
    else
      @movies = Movie.all
    end
  end

  def show
    id = params[:id]
    @movie = Movie.find(id)
  end

  def new
    @movie = Movie.new
  end

  def create
    #@movie = Movie.create!(params[:movie]) #did not work on rails 5.
    @movie = Movie.create(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created!"
    redirect_to movies_path
  end

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def edit
    id = params[:id]
    @movie = Movie.find(id)
    #@movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    #@movie.update_attributes!(params[:movie])#did not work on rails 5.
    @movie.update(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated!"
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find params[:id]
    @movie.destroy
    flash[:notice] = "#{@movie.title} was deleted!"
    redirect_to movies_path
  end
end
