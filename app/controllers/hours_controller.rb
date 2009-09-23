class HoursController < ApplicationController

  before_filter :hours_ix

  def new
    render :update do |page|
      i = session[:hours_ix] 
      page.insert_html :bottom, 'hours_table', :partial => 'hour', :locals => {:i => i}
      page.visual_effect :highlight, "hour#{i}"
    end
    session[:hours_ix] += 1
  end

  def destroy
    session[:hours_ix] -= 1
    render :update do |page|
      page.remove "hour#{params[:row_id]}"
    end
  end

  private
  def hours_ix
    session[:hours_ix] ||= params[:hours_ix].to_i
  end

end
