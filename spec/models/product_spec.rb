require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "valid if name, price, quantity, and category set" do
      @category = Category.create(name: "new_cat") 
      @product = Product.new(name: "Bengal", price: 300, quantity: 3, category: @category)
      expect(@product).to be_valid
    end
    it "not valid if name not set" do
      @category = Category.create(name: "new_cat") 
      @product = Product.new(name: "", price: 300, quantity: 3, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eql(["Name can't be blank"])
    end
    it "not valid if price not set" do
      @category = Category.create(name: "new_cat") 
      @product = Product.new(name: "Bengal", price: nil, quantity: 3, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eql(["Price cents is not a number", "Price is not a number", "Price can't be blank"])
    end
    it "not valid if quantity not set" do
      @category = Category.create(name: "new_cat") 
      @product = Product.new(name: "Bengal", price: 300, quantity: nil, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eql(["Quantity can't be blank"])
    end
    it "not valid if category not set" do
      @category = Category.create(name: "new_cat") 
      @product = Product.new(name: "Bengal", price: 300, quantity: 3, category: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eql( ["Category can't be blank"])
    end
  end
end
