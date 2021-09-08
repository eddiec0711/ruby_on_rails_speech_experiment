class Question::Rating < Question
  has_one :scale, dependent: :destroy
  validates :scale, presence: true

  def type_name
    "Rating scale"
  end
end
