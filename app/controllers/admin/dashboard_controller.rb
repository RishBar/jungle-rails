class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_BASIC_AUTH_USER'], password: ENV['HTTP_BASIC_AUTH_PASS']
  def show
    @categories = Category.all
    @items_per_category = @categories.map { |category| category.products.length }
  end
end