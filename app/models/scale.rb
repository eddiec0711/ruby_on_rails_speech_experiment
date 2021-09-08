class Scale < ApplicationRecord
    belongs_to :rating
    validates :rating, presence: true
    validates :bins, presence: true, numericality: { greater_than_or_equal_to: 2, less_than_or_equal_to: 20 }
end
