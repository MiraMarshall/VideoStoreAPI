class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: customers.as_json(only: [:name, :registered_at, :adress, :city, :state, :postal_code, :phone]), status: :ok
  end

  def show
    customer = Customer.find_by(id: params[:id])
    if customer
      render status: :ok, json: customer.as_json(only: [:name, :registered_at, :adress, :city, :state, :postal_code, :phone]), status: :ok
    else
      render status: :not_found, json: { errors: "Customer not found " }
      # there could be more than one error
    end
  end

  def zomg
    render status: :not_found, json: { errors: "It works " }
    # there could be more than one error
  end
end