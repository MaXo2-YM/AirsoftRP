class InvertKey < ActiveRecord::Migration[5.2]
	def change
		add_column :characters, :userId, :integer
		add_index :characters, :userId
		
		remove_index :users, :charactersIds
		remove_column :users, :charactersIds
	end
end
