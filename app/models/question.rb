class Question < ApplicationRecord
  belongs_to :quiz
  has_many :choices, dependent: :destroy

  validates :question, presence: true
end
