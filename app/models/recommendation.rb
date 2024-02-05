require 'uri'

class Recommendation < ApplicationRecord
  belongs_to :quiz

  validates :link, presence: true, format: { with: URI.regexp }
end
