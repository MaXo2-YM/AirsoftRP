class ModifNomsColonnes < ActiveRecord::Migration[5.2]
	def change
		rename_column(:users, :lastName, :last_name)
		rename_column(:users, :firstName, :first_name)
		rename_column(:users, :passwordEncrypted, :encrypted_password)
		rename_column(:users, :dateInsc, :inscription_date)
		
		rename_column(:characters, :lastName, :last_name)
		rename_column(:characters, :firstName, :first_name)
		rename_column(:characters, :xpPoints, :experience_points)
		rename_column(:characters, :userId, :user_id)
	end
end
