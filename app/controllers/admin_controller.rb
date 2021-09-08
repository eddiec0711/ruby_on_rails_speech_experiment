class AdminController < ApplicationController
  before_action :authorize_admin

  def users
    @current_nav_identifier = 'admin_tools'
    @users = User.all
  end

  def set_admin
    user = User.find(params[:user_id])
    user.admin = true
    if user.save
      redirect_to admin_see_users_path
    else
      puts "error while setting admin"
    end
  end

  def delete_user
    @user = User.find(params[:user_id])
    if @user.id != current_user.id
      if @user.destroy 
        redirect_to admin_see_users_path
      else
        puts 'error while deleting user'
      end
    else
      flash[:alert] = "To delete your own account go to settings"
      redirect_to admin_see_users_path
    end
  end

  def view_user
    
    @user = User.find(params[:user_id])
    render layout: false
  end
  
 
end