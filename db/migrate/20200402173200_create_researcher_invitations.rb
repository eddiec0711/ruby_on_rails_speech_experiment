class CreateResearcherInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :researcher_invitations do |t|
      t.string :registration_code # single-use code used to register
      t.boolean :used, :default => 0 #yes if someone registered using this link



      t.belongs_to :user #researcher account, probably an admin, 
                         #the one who created this invitation
      t.timestamps
    end
  end
end
