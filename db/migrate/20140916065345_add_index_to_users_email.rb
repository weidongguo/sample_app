class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :users, :email, unique: true
  
    # add_index() adds an index to the email column of the users table.
  end
end
