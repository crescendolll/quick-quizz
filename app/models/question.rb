class Question < ApplicationRecord
  belongs_to :quiz
  has_many :choices, dependent: :destroy
  # attr_accessor :content
  validates :question, presence: true
  # after_create :generate_choices


  # private
  # def generate_choices
  #   binding.pry
  #   console.log(content)
  #   # choices.create()
  # end
end
