class Admin::VersionsController < Admin::AdminController
  load_and_authorize_resource
  before_filter :set_page_id

  def set_page_id
   @page_id = "admin"
   @title = "Admin Versions"
  end
  
  def index
    @versions = Version.all
  end
  
  def new
    @version = Version.new
    @submit_path = admin_versions_path
  end
  
  def edit
    @version = Version.find(params[:id])
    @submit_path = admin_version_path(@version)
  end
  
  def update
    @version = Version.find(params[:id])
    @submit_path = admin_version_path(@version)
    if @version.update_attributes(version_params)
      redirect_to admin_versions_path, :notice => "Version #{t(:update_success)}"
    else
      render :action => "edit", :id => params[:id]
    end
  end
  
  def create
    @version = Version.new(version_params)
    @submit_path = admin_versions_path
    if @version.save
      redirect_to admin_versions_path, :notice => "Version #{t(:create_success)}"
    else
      render :action => "new"
    end
  end
  
  def destroy
    @version = Version.find(params[:id])
    if @version.destroy
      redirect_to admin_versions_path, :notice => "Version #{t(:delete_success)}"
    else
      render :action => "index", :notice => "Version #{t(:delete_fail)}"
    end
  end

  private
  def version_params
    params.require(:version).permit(:name, :sort_order, :product_id, :documentation_url, :status, :dll_paths, :namespace, :class_name, :com_object, :object_name, :docs_url, :builds, :use_dispose, :beta)
  end

end
