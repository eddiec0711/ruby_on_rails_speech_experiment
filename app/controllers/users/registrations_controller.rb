# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @current_nav_identifier = 'sign_up'
    @url_reg_code = params[:registration_code]
    super
  end

  # POST /resource
  def create

    registration_code = params[:user][:registration_code]

    invitation = ResearcherInvitation.find_by( registration_code: registration_code )
    
    if(!invitation.nil? && !invitation.used)
      super
    else
      flash[:alert] = "Invalid Registration Code"
      redirect_to new_user_registration_path(:registration_code => registration_code)
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  def destroy
    if resource.admin and User.where(admin: true).size == 1
      flash[:alert] = "You cannot delete the last admin"
      redirect_to edit_user_registration_path
      puts "only admin, cannot delete"
    else
      super
    end

  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :institution, :country, :funded, 
      :email, :password, :password_confirmation, :mailing_list, :faculty, :research_level])
    # params.require(:user).permit(:name, :institution, :country, :funded, 
    #   :email, :password, :password_confirmation, :mailing_list, :faculty, :research_level)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :institution, :country, :funded, 
      :email, :password, :password_confirmation, :mailing_list, :faculty, :research_level])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)

    registration_code = params[:user][:registration_code]
    
    invitation = ResearcherInvitation.find_by(:registration_code => registration_code)
    invitation.used = true
    invitation.save!

    super(resource)
    
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
