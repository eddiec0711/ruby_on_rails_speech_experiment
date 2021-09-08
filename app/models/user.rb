class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :experiments, dependent: :destroy
  has_many :tasks, through: :experiments
  has_many :researcher_invitations, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :country
  validates_presence_of :email
  # validates_presence_of :password
  validates_presence_of :research_level
  attr_accessor :registration_code
end
