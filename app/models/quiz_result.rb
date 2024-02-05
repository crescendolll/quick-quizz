class QuizResult < ApplicationRecord
  belongs_to :quiz
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :result, presence: true, numericality: true
end
