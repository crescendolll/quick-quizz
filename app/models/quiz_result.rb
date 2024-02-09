class QuizResult < ApplicationRecord
  belongs_to :quiz
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :result, presence: true, numericality: true
  accepts_nested_attributes_for :answers

  def result_percentage
    result*10
  end
end
