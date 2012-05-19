class PasswordsController < ApplicationController
  # In case user is logged in and their password expired,
  # edit password is available.
  # Hence before_filter in ApplicationController is ignored.
  skip_before_filter :authenticate_or_examine!, :if => :user_signed_in?
  def edit
    render :locals => { :user => current_user }
  end

  def update
    @user = User.find(current_user.id)
    if @user.valid_password?(params[:old_password])
      @user.password_updated_at = DateTime.now
      if @user.update_attributes(params[:user])
        Password.store_password @user
        flash[:notice] = "Password has been updated"
        sign_in @user, :bypass => true
        redirect_to root_path
      else
        flash[:errors] = @user.errors
        render "edit", :locals => { :user => @user }
      end
    else
      @user.errors.add(:password, 'Old password is incorrect')
      flash[:errors] = @user.errors
      render "edit", :locals => { :user => @user }
    end
  end

end
