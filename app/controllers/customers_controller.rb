class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone]), status: :ok
  end

  def show
    customer = Customer.find_by(id: params[:id])
    if customer
      render status: :ok, json: customer.as_json(only: [:name, :registered_at, :adress, :city, :state, :postal_code, :phone]), status: :ok
    else
      render status: :not_found, json: {errors: customer.errors.messages}
      # there could be more than one error
    end
  end

  # def zomg
  #   render status: :not_found, json: { message: "It works " }
  #   # there could be more than one error
  # end

  private

  def customer_params
    params.require(:customer).permit(:name, :registered_at, :postal_code, :phone)
  end
end
