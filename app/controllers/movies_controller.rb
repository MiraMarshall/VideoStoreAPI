class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :title, :release_date]), status: :ok
  end

  private

  def params
    params.require(:movie).permit(:title, :release_date)
  end
end
