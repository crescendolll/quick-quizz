class ChangeAnswerToAnswers < ActiveRecord::Migration[7.1]
  def change
    rename_column :recommendations, :answer, :answers
  end
end
