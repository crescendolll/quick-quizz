class Quiz < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :quiz_results, dependent: :destroy
  has_many :quiz_takers, through: :quiz_results, source: :user
  has_many :recommendations, dependent: :destroy
  attr_accessor :text

  # validates :title, presence: true
end
