class CreateQuizResults < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_results do |t|
      t.references :quiz, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.float :result

      t.timestamps
    end
  end
end
