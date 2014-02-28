class CreateUsers < ActiveRecord::Migration
  def change
	# 'change' method uses the Rails method 'create_table' to create a table in the db for storing users
  	# The create_table method accepts a block with one block variable (t)
  	# the create_table method uses the t object to create name and email columns in the db, both of type string
  	  create_table :users do |t|  # table name is plural (users) even though the model name is singular (User)
      t.string :name
      t.string :email

      t.timestamps  # special command that creates two 'magic columns' called 'created_at' and 'updated_at'
    end
  end
end
