require "date"
require "pry"

class RentalsController < ApplicationController
  def check_out
    rental = Rental.create(rental_params)

    rental.check_out = DateTime.now.to_date
    rental.due_date = rental.check_out + 7
    rental.save
    # binding.pry

    if rental
      render status: :ok, json: { id: rental.id }
    else
      render status: :bad_request, json: { ok: false, errors: rental.errors }
    end
  end

  def check_in
    customer = Customer.find_by(id: params[:customer_id])
    movie = Movie.find_by(id: params[:movie_id])
    rental = Rental.find_by(customer_id: customer.id, movie_id: movie.id)
    #binding.pry

    if rental
      movie.update(available_inventory: movie.available_inventory += 1)
      # customer.movies_checked_out -= 1
      rental.check_in = Date.today

      render json: { id: rental.id }, status: :ok
    else
      render status: :not_found, json: { ok: false, mesages: "Movie not found" }
    end
  end

  private

  def rental_params
    params.permit(:movie_id, :customer_id)
  end
end
