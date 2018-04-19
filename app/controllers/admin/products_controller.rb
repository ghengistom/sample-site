class Admin::ProductsController < Admin::AdminController
  load_and_authorize_resource
  before_filter :set_page_id

  def set_page_id
   @page_id = "admin"
   @title = "Admin Products"
  end
  
  def index
    @products = Product.all
  end
  
  def new
    @product = Product.new
    @submit_path = admin_products_path
  end
  
  def update
    @product = Product.find(params[:id])
    @submit_path = admin_product_path(@product)
    if @product.update_attributes(product_params)
      redirect_to admin_products_path, :notice => "Product #{t(:update_success)}"
    else
      render :action => "edit", :id => params[:id]
    end
  end
  
  def edit
    @product = Product.find(params[:id])
    @submit_path = admin_product_path(@product)
  end
  
  def create
    @product = Product.new(product_params)
    @submit_path = admin_products_path
    if @product.save
      redirect_to admin_products_path, :notice => "Product #{t(:create_success)}"
    else
      render :action => "new"
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to admin_products_path, :notice => "Product #{t(:delete_success)}"
    else
      render :action => "index", :notice => "Product #{t(:delete_fail)}"
    end
  end

  private
  def product_params
    params.require(:product).permit(:name)
  end

end
