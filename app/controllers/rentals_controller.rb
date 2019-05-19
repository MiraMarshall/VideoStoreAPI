require "date"

class RentalsController < ApplicationController
  def check_out
    rental = Rental.new(rental_params)
    movie = Movie.find_by(id: rental.movie_id)
    if movie.available_inventory == 0
      render status: :not_found, json: { ok: false, mesages: "Movie not found" }
    end

    rental.check_out = DateTime.now.to_date
    rental.due_date = rental.check_out + 7

    if rental.save
      customer = Customer.find_by(id: rental.customer_id)

      customer_movie_count = customer.movies_checked_out_count
      customer.update(movies_checked_out_count: customer_movie_count + 1)

      movie_inventory = movie.available_inventory
      movie.update(available_inventory: movie_inventory - 1)

      render status: :ok, json: { id: rental.id }
    else
      render status: :bad_request, json: { ok: false, errors: rental.errors }
    end
  end

  def check_in
    rental = Rental.where(["movie_id = ? and customer_id = ?", params[:rental][:movie_id], params[:rental][:customer_id]]).first
    customer = Customer.find_by(id: params[:rental][:customer_id])
    movie = Movie.find_by(id: params[:rental][:movie_id])
    rental.check_in = Date.today

    if rental.save
      customer.movies_checked_out_count -= 1
      customer.save
      movie.available_inventory += 1
      movie.save

      render json: { id: rental.id }, status: :ok
    else
      render status: :not_found, json: { ok: false, mesages: "Movie not found" }
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:movie_id, :customer_id)
  end
end
