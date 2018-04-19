class Admin::FeedbackController < Admin::AdminController
  load_and_authorize_resource
  def list
    @feedbacks = Feedback.order('created_at desc').all
  end
  
  def view
    @feedbacks = Feedback.where("content LIKE 'example-?%'", params[:id].to_i)
    @example = Example.find_by_id(params[:id])
  end
  
  def destroy
    @feedback = Feedback.find(params[:id])
    if @feedback.destroy
      redirect_to :back, :notice => "Feedback was deleted."
    else
      render :action => view, :notice => "There was an error deleting the feedback."
    end
  end
end
