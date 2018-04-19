class TrackController < ApplicationController
  
  def hit
    if params[:content]
      render :text => "ok" if !can?(:manage, :all) && Hit.new(:content => params[:content]).save
    else
      render :text => "error"
    end
  end

end
