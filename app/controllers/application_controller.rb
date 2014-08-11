class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exceptionz
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :permission_denied

  layout :page_layout

  # Filtering privilages.
  def permission_denied
    location = (request.referrer ||  after_sign_in_path_for(current_user))
    redirect_to location, alert: "You are not authorized to perform this action."
  end

  private

  # Overwriting the sign_in redirect path method
  def after_sign_in_path_for(resource) 
    if resource.has_role? :admin
      admins_path
    else
      if current_user.updated?
        home_path
      else
      edit_user_path(current_user)
      end
    end
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def page_layout
    if current_user.nil?
      "landing_layout"
    end
  end

end
