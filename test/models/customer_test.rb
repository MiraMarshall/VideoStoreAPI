require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  it "must be valid" do
    value(customer).must_be :valid?
  end
  describe "validations" do
    let(:product2) { products(:two) }
    it "description is required" do
      product.description = ""
      product.save
      expect(product.valid?).must_equal false
      product.errors.messages.must_include :description
      product.errors[:description].include?("can't be blank")
    end

    it "requires a photo_url" do
      product.photo_url = ""
      product.save
      expect(product.valid?).must_equal false
      product.errors.messages.must_include :photo_url
      product.errors[:photo_url].include?("can't be blank")
    end

    it "requires a name" do
      product.name = ""
      product.save
      expect(product.valid?).must_equal false
      product.errors.messages.must_include :name
      product.errors[:name].include?("can't be blank")
    end

    it "requires a unique name" do
      product2.name = "manny"
      product2.save
      expect(product2.valid?).must_equal false
      product2.errors.messages.must_include :name
      product2.errors[:name].include?("has already been taken")
    end

    it "requires a price" do
      product.price = ""
      product.save
      expect(product.valid?).must_equal false
      product.errors.messages.must_include :price
      product.errors[:price].include?("can't be blank")
    end

    it "requires a price greater than 0" do
      product.price = 0
      product.save
      expect(product.valid?).must_equal false
      product.errors.messages.must_include :price
      product.errors[:price].include?("must be greater than 0")
    end

    it "requires an inventory not nil" do
      product.inventory = 0
      product.save
      expect(product.valid?).must_equal false
      product.errors.messages.must_include :inventory
      product.errors[:inventory].include?("must be greater than 0")
    end
  end
end
