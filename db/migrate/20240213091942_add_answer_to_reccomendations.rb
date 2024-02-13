class AddAnswerToReccomendations < ActiveRecord::Migration[7.1]
  def change
    add_column :recommendations, :answer, :text
  end
end
