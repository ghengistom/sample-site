class Admin::SnippetsController < Admin::AdminController
  load_and_authorize_resource
  before_filter :set_page_id
  
  def set_page_id
   @page_id = "admin"
   @title = "Admin Snippets"
  end
  
  def index
    @categories = Category.with_snippets.order('name')
  end
  
  def new
    @snippet = Snippet.new
    @snippet.category_id = Category.where(name: 'Unknown').first.id
    @submit_path = admin_snippets_path
    set_products_versions
  end
  
  def create
    @snippet = Snippet.new(snippet_params)
    @submit_path = admin_snippets_path
    set_products_versions
    if @snippet.save
      redirect_to admin_snippets_path, :notice => "Snippet was successfully updated."
    else
      render :action => "new"
    end
  end
  
  def edit
    @snippet = Snippet.find(params[:id])
    @submit_path = admin_snippet_path(@snippet)
    set_products_versions
    @title = "#{@snippet.id}: #{@snippet.name} - Edit Snippet"
  end
  
  def update
    params[:snippet][:attachment_ids] ||= []
    @snippet = Snippet.find(params[:id])
    @submit_path = admin_snippet_path(@snippet)
    set_products_versions
    if @snippet.update_attributes(snippet_params)
      redirect_to admin_snippets_path, :notice => "Snippet was successfully updated."
    else
      render :action => "edit", :id => params[:id]
    end
  end
  
  def destroy
    @snippet = Snippet.find(params[:id])
    if @snippet.destroy
      redirect_to admin_snippets_path, :notice => "Snippet was deleted."
    else
      render :action => "index", :notice => "There was an error deleting the snippet."
    end
  end

  private
  def snippet_params
    params.require(:snippet).permit(:id, :name, :code, :category_id, {:attachment_ids => []}, :versions)
  end
  
end
