class Admin::DashboardController < Admin::BaseController
  def show
    @categories = Category.all
    @category = Category.new
    @total = Category.all.map { |category| category.products.length }
                     .inject(:+)
  end
end