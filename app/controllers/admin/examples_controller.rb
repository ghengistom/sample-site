class Admin::ExamplesController < Admin::AdminController
  load_and_authorize_resource
  before_filter :set_page_id
  before_filter :set_products_versions

  def set_page_id
   @page_id = "admin"
   @title = "Admin Examples"
  end
  
  def get_potential_clones
    # Gather array of products and examples usable with options_for_select
    @potential_clones = Hash.new
    @potential_clones[:products] = Array.new
    @potential_clones[:examples] = Hash.new
    
    # Add empty product for selection of no clone
    @potential_clones[:products] << ["none", "none"]
    @potential_clones[:examples]["none"] = ["none", "none"]
    
    Product.order('name').each do |p|
      # Get each product and assign it to :products
      @potential_clones[:products] << [p.name,p.id]
      @potential_clones[:examples][p.id] = Array.new
      
      # For each product, get the examples linked to it
      examples = p.examples.order('title')
      examples.where(["examples.id != ?",@example.id]) if @example.id
      examples.each do |e|
        @potential_clones[:examples][p.id] << [e.title,e.id]
      end
    end
    
    @potential_clones[:examples].each do |id,data|
      # Remove any products that have no examples
      if data.empty?
        product = Product.find(id)
        @potential_clones[:products].delete([product.name,product.id])
        @potential_clones[:examples].delete(id)
      end
    end
  end
  
  def index
    @examples = Example.page(params[:page])
  end
  
  def new
    @example = Example.new
    @example.code = "with_version do |n|\n  \nend"
    @products = Product.all
    @submit_path = admin_examples_path
    @example.category_id = Category.where(name: 'Unknown').first.id
    get_potential_clones
  end
  
  def update
    params[:example][:attachment_ids] ||= []
    @example = Example.find(params[:id])
    @products = Product.all
    @submit_path = admin_example_path(@example)
    
    get_potential_clones
        
    if @example.update_attributes(example_params)
      @example.reload
      
      # if we have a "ref" to redirect to, then use it
      if params[:ref]
        url = params[:ref]
      else
        ref = {
          :product => @example.products.first.name,
          :version => @example.products.first.latest_version.name,
          :title => @example.title
        }
        url = examples_path ref
      end
      
      redirect_to url, :notice => "Example #{t(:update_success)}"
    else
      render :action => "new"
    end
  end
  
  def edit
    @example = Example.find(params[:id])
    @products = Product.all
    @submit_path = admin_example_path(@example)
    @feedback = Feedback.where("content LIKE 'example-#{@example.id}%'")
    
    @title = "#{@example.id}: #{@example.title} - Edit Example"
    
    get_potential_clones
  end
  
  def destroy
    @example = Example.find(params[:id])
    if @example.destroy
      redirect_to admin_examples_path, :notice => "Example was deleted."
    else
      render :action => "index", :notice => "There was an error deleting the example."
    end
  end
  
  def create
    params[:example][:attachment_ids] ||= []
    @example = Example.new(example_params)
    @products = Product.all
    @attachments = Attachment.all
    @submit_path = admin_examples_path
    
    if @example.save
      @example.reload
      redirect_to examples_path(:product => @example.products.first.name, :version => @example.products.first.latest_version_from_all.name, :title => @example.title), :notice => "Example was successfully created."
      # p @example.products
    else
      get_potential_clones
      render :action => "new"
    end
  end

  private
  def example_params
    params.require(:example).permit!
  end

end
