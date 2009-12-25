# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_administrator_session, :current_administrator
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  layout "application"

  before_filter :require_auth, :set_locale

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  def initialize
    CalendarDateSelect.format = :hyphen_ampm
    WillPaginate::ViewHelpers.pagination_options[:previous_label]=I18n.t("pagination.prev")
    WillPaginate::ViewHelpers.pagination_options[:next_label]=I18n.t("pagination.next")
  end

  private
  def current_administrator_session
    return @current_administrator_session if defined?(@current_administrator_session)
    @current_administrator_session = AdministratorSession.find
  end

  def current_administrator
    return @current_administrator if defined?(@current_administrator)
    @current_administrator = current_administrator_session && current_administrator_session.administrator
  end
  
  def require_auth
    unless current_administrator
      flash[:notice] = I18n.t('flash.login.must_login') 
      redirect_to new_administrator_session_url
      return false
    end
  end

  def require_no_auth
  end
  protected
  def set_locale
    if params[:locale]
      session[:locale] = params[:locale]
    end
    I18n.locale = session[:locale]
  end

end

