class Answer < ApplicationRecord
  belongs_to :choice
  belongs_to :quiz_result
  has_many :recommendations, dependent: :destroy
end
