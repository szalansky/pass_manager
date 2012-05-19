class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_or_examine!, :unless => :devise_controller? 

  protected
    def authenticate_or_examine!
      if user_signed_in?
        if current_user.password_expired?
          redirect_to edit_password_path, :locals => { :user => current_user } 
        end
      else
        redirect_to new_user_session_path
      end
    end
end
