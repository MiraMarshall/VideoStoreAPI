require "date"

class RentalsController < ApplicationController
  def check_out
    rental = Rental.new(rental_params)
    rental.check_out = DateTime.now.to_date
    rental.due_date = rental.check_out + 7
    rental.save

    if rental
      render status: :ok, json: rental.as_json(only: [:id, :customer_id, :movie_id, :due_date])
    else
      render status: :bad_request, json: { ok: false, errors: rental.errors }
    end
  end

  def check_in
    customer = Customer.find_by(id: params[:customer_id])
    movie = Movie.find_by(id: params[:movie_id])
    rental = Rental.find_by(customer_id: customer, movie_id: movie.id)
    #binding.pry

    if rental
      # movie.inventory += 1
      # customer.movies_checked_out -= 1
      # rental.check_in = Date.today

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
