class AddNomPrenomPseudoTablePerso < ActiveRecord::Migration[5.2]
	def change
		add_column :users, :lastName, :string
		add_column :users, :firstName, :string
		add_column :users, :username, :string
		add_column :users, :passwordEncrypted, :string
		add_column :users, :salt, :string
		add_column :users, :dateInsc, :timestamp
		add_column :users, :charactersIds, :integer, array: true
		add_index :users, :charactersIds
		
		create_table :characters
		add_column :characters, :lastName, :string
		add_column :characters, :firstName, :string
		add_column :characters, :age, :integer
		add_column :characters, :sex, :string
		add_column :characters, :background, :text
		add_column :characters, :xpPoints, :integer
		add_column :characters, :money, :decimal
	end
end
