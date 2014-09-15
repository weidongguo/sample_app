class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|   #create_table is a Rails method that creates a table in the
                                 #database for storing users. It accepts a block with one
                                 #block variable. In this case called t (for "table")
      t.string :name
      t.string :email

      t.timestamps # creates two columns called created_at and updated_at(both->type datetime)

    end
  end
end
