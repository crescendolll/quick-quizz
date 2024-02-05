class Choice < ApplicationRecord
  belongs_to :question
  has_many :answers, dependent: :destroy

  validates :choice, presence: true
  validates :correct, inclusion: { in: [true, false] }
end
