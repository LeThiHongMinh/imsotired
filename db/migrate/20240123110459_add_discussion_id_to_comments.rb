class AddDiscussionIdToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :discussion_id, :integer
  end
end
