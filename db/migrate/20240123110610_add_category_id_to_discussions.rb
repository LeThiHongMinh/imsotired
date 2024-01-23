class AddCategoryIdToDiscussions < ActiveRecord::Migration[7.1]
  def change
    add_column :discussions, :category_id, :integer
  end
end
