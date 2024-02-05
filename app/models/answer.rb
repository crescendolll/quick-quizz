class Answer < ApplicationRecord
  belongs_to :choice
  belongs_to :quiz_result
end
