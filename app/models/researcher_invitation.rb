class ResearcherInvitation < ApplicationRecord
    belongs_to :user

    validates :registration_code, presence: true
    validates_uniqueness_of :registration_code
    

    def get_link
      if self.used.nil? || self.used == ""
        return null
      else
        return Rails.application.config.app_url + "/users/sign_up?registration_code=" + self.registration_code
      end
    end
end
