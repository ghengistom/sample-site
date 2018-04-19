class Admin::CategoriesController < Admin::AdminController
  load_and_authorize_resource
  before_filter :set_page_id
  
  def set_page_id
   @page_id = "admin"
   @title = "Admin Categories"
  end
  
  def index
    @categories = Category.order('name')
  end
  
  def new
    @category = Category.new
    @submit_path = admin_categories_path
  end
  
  def create
    @category = Category.new(category_params)
    @submit_path = admin_categories_path
    if @category.save
      redirect_to admin_categories_path, :notice => "Category #{t(:create_success)}"
    else
      render :action => "new"
    end
  end
  
  def edit
    @category = Category.find(params[:id])
    @submit_path = admin_category_path(@category)
  end
  
  def update
    @category = Category.find(params[:id])
    @submit_path = admin_category_path(@category)
    if @category.update_attributes(category_params)
      redirect_to admin_categories_path, :notice => "Category #{t(:update_success)}"
    else
      render :action => "edit", :id => params[:id]
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to admin_categories_path, :notice => "Category #{t(:delete_success)}"
    else
      render :action => "index", :alert => "Category #{t(:delete_fail)}"
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
  
end
