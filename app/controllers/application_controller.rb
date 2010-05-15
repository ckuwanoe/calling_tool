# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  before_filter :val_session
  
  private
  def val_session
    if params[:rsess]
      request.session.instance_eval("@by").send(:unmarshal, request.cookies[ActionController::Base.session_options[:key]])
    else
      #redirect_to login_path and return unless current_user
    end
  end
end
