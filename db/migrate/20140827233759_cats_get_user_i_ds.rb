class CatsGetUserIDs < ActiveRecord::Migration
  def change
    # add_column :table_name, :column_name, :type, options_hash
    add_column :cats, :user_id, :integer
    add_index :cats, :user_id
  end
  
end
