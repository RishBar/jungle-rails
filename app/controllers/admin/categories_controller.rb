class Admin::CategoriesController < Admin::BaseController
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_root_path, notice: 'Category created!'
    else
      redirect_to admin_root_path, notice: 'Category could not be created!'
    end
  end
  
  private

  def category_params
    params.require(:category).permit(
      :name
    )
  end
end