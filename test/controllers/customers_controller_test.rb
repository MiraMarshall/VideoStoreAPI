require "test_helper"

describe CustomersController do
  let(:customer) { customers(:chewy) }

  it "should get index" do
    get customers_index_url
    value(response).must_be :success?
  end

  it "can get show" do
    get customer_path(customers(:chewy).id)
    value(response).must_be :success?
  end
end
