class ChangeAnswersToAnswer < ActiveRecord::Migration[7.1]
  def change
    rename_column :recommendations, :answers, :recommendation
  end
end
