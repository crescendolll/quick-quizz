class AddTitleToQuiz < ActiveRecord::Migration[7.1]
  def change
    add_column :quizzes, :title, :string
  end
end
