class AdministratorSessionsController < ApplicationController
  before_filter :require_auth, :except => [:new, :create]
  def new
    if current_administrator
      redirect_to :controller => "students"
    end
    @administrator_session = AdministratorSession.new
  end
  def create
    @administrator_session = AdministratorSession.new(params[:administrator_session])
    if @administrator_session.save
      flash[:notice] = "Login successful!"
      redirect_to :controller => 'students'
    else
      render :action => :new
    end
  end
  def destroy
    logger.info "logout!!!!"
    current_administrator_session.destroy
    flash[:notice] = "Logout successful!"
    reset_session
    redirect_to :action => :new
  end
end
