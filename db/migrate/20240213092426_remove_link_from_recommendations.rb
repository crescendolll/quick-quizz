class RemoveLinkFromRecommendations < ActiveRecord::Migration[7.1]
  def change
    remove_column :recommendations, :link, :string
  end
end
