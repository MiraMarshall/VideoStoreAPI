class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :title, :release_date]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if !movie
      render status: :not_found, json: {ok: false, messages: "Movie was not found!"}
    else
      render status: :ok, json: movie.as_json(only: [:id, :title, :release_date, :inventory])
    end
  end

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render status: :ok, json: movie.as_json(only: [:id, :title, :release_date, :inventory])
    else
      render status: :bad_request, json: {ok: false, errors: movie.errors.messages}
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :release_date, :inventory)
  end
end
