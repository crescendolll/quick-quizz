require 'uri'

class Recommendation < ApplicationRecord
  belongs_to :answer

  validates :recommendation, presence: true
end
