class Quiz < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :quiz_results, dependent: :destroy
  has_many :quiz_takers, through: :quiz_results, source: :user
  has_many :recommendations, dependent: :destroy

  validates :title, presence: true
end
