class RemoveWordsFromAssets < ActiveRecord::Migration
  def change
    remove_column :assets, :words
  end
end
