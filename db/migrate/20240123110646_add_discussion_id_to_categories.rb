class AddDiscussionIdToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :discussion_id, :integer
  end
end
