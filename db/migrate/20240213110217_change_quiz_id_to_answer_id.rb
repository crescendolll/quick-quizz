class ChangeQuizIdToAnswerId < ActiveRecord::Migration[7.1]
  def change
    remove_reference :recommendations, :quiz, index: true, foreign_key: true
    add_reference :recommendations, :answer, index: true, foreign_key: true
  end
end
