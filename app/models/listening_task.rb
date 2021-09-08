class ListeningTask < ApplicationRecord
  acts_as :task # inherits from task model

  validates :listens, presence: true

  def type_name
    "Audio hearing"
  end

  def self.tooltip
    "Listen to audio sample"
  end
end
