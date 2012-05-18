class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_or_examine

  protected
    def authenticate_or_examine
      if user_signed_in?
        redirect_to password_change_path if current_user.password_expired?
      else
        redirect_to new_user_session_path
      end
    end
end
