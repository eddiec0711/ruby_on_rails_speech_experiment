class ResearcherInvitationsController < ApplicationController
  before_action :authorize_admin
  before_action :set_researcher_invitation, only: [:destroy]
  prepend_view_path "app/views/admin"

  def index
    @current_nav_identifier = 'admin_tools'
    @invitations = current_user.researcher_invitations
    @invitation = ResearcherInvitation.new
  end

  def create
    require 'securerandom'

    randomString = ''
    loop do
      randomString = SecureRandom.hex
      break unless ResearcherInvitation.where(:registration_code => randomString).exists?
    end

    current_user.researcher_invitations.create({:registration_code => randomString})

    redirect_to researcher_invitations_path
 
  end


  def destroy
    puts params
    @invitation.destroy
    redirect_to researcher_invitations_path, notice: 'Invitation was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_researcher_invitation
      @invitation = ResearcherInvitation.find(params[:id])
    end
  
end