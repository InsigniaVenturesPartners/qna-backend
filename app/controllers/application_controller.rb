require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :null_session

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { head :forbidden, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  #return user to sign in page after logout
  def after_sign_out_path_for(resource_or_scope)
    "/users/sign_in"
  end
end
