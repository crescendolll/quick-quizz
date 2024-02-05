class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.references :choice, null: false, foreign_key: true
      t.references :quiz_result, null: false, foreign_key: true

      t.timestamps
    end
  end
end
