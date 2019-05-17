require "test_helper"

describe RentalsController do
  # let(:customer) { customers(:beyonce) }
  # let(:movie) { movies(:one) }
  # let(:rental) { rentals(:one) }

  describe "check_out" do
    # it "creates a new rental"
    let(:rental_data) {
      {
        customer_id: customers(:beyonce).id,
        movie_id: movies(:one).id,

      }
    }

    it "can create a new rental " do
      expect {
        post check_out_path, params: rental_data
      }.must_change "Rental.count", 1

      must_respond_with :success
    end
  end
end

#   it "returns bad request for bad customer params data" do
#     rentals.delete(:customer_id)
#     proc {
#       post check_out_path, params: rentals
#     }.must_change "Rental.count", 0

#     must_respond_with :bad_request
#     body = JSON.parse(response.body)
#     body.must_be_kind_of Hash
#     body.must_include "errors"
#     body["errors"].must_include "customer"
#   end

#   it "returns bad request for bad movie params data" do
#     rentals.delete(:movie_id)
#     proc {
#       post check_out_path, params: rentals
#     }.must_change "Rental.count", 0

#     must_respond_with :bad_request
#     body = JSON.parse(response.body)
#     body.must_be_kind_of Hash
#     body.must_include "errors"
#     body["errors"].must_include "movie"
#   end
# end
