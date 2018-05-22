class TableUsers < ActiveRecord::Migration[5.2]
	def change
		create_table :users
		add_column :users, :mail, :string
		delete_column :ids
	end
end
