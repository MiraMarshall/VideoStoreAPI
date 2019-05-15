class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :title, :release_date]), status: :ok
  end

  def create
    movie = Movie.create(movie_params)
    if movie.valid?
      render json: {id: movie.id}, status: :ok
    else
      render json: {errors: movie.errors}, status: :bad_request
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :release_date, :inventory, :overview)
  end
end
