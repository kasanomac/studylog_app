class AddUserIdToStudytimes < ActiveRecord::Migration[7.1]
  def change
    add_column :studytimes, :user_id, :integer
  end
end
