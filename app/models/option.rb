class Option < ApplicationRecord
    belongs_to :chooseable, polymorphic: true
    validates :contents, presence: true
end
