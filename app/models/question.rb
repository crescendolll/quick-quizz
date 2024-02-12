class Question < ApplicationRecord
  belongs_to :quiz
  has_many :choices, dependent: :destroy
  validates :question, presence: true
  attr_accessor :content

  def generate_choices(content)
    choices.create([
      {choice: content["options"]["option1"]["body"], correct: content["options"]["option1"]["isItCorrect"]},
      {choice: content["options"]["option2"]["body"], correct: content["options"]["option2"]["isItCorrect"]},
      {choice: content["options"]["option3"]["body"], correct: content["options"]["option3"]["isItCorrect"]},
      {choice: content["options"]["option4"]["body"], correct: content["options"]["option4"]["isItCorrect"]}
    ])
  end
end
