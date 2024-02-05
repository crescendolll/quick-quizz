class CreateRecommendations < ActiveRecord::Migration[7.1]
  def change
    create_table :recommendations do |t|
      t.references :quiz, null: false, foreign_key: true
      t.string :link

      t.timestamps
    end
  end
end
