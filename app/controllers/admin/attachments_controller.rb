class Admin::AttachmentsController < Admin::AdminController
  load_and_authorize_resource
  before_filter :set_page_id
  
  def set_page_id
   @page_id = "admin"
   @title = "Admin Attachments"
  end

  def index
    @attachments = Attachment.all
    @attachment = Attachment.new
    @submit_path = admin_attachments_path
  end
  
  def new
    @attachment = Attachment.new
    @submit_path = admin_attachments_path
  end
  
  def edit
    @attachment = Attachment.find(params[:id])
    @submit_path = admin_attachment_path(@attachment)
  end
  
  def update
    @attachment = Attachment.find(params[:id])
    @submit_path = admin_attachment_path(@attachment)
    if @attachment.update_attributes(attachment_params)
      redirect_to admin_attachments_path, :notice => "Attachment #{t(:update_success)}"
    else
      render :action => "edit", :id => params[:id]
    end
  end
  
  def create
    @attachment = Attachment.new(attachment_params)
    @submit_path = admin_attachments_path
    if @attachment.save
      redirect_to admin_attachments_path, :notice => "Attachment #{t(:create_success)}"
    else
      render :action => "new"
    end
  end
  
  def destroy
    @attachment = Attachment.find(params[:id])
    if @attachment.destroy
      redirect_to admin_attachments_path, :notice => "Attachment #{t(:delete_success)}"
    else
      render :action => "index", :notice => "Attachment #{t(:delete_fail)}"
    end
  end

  private
  def attachment_params
    params.require(:attachment).permit(:file)
  end
end
