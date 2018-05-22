class ModifsIdsEnMail < ActiveRecord::Migration[5.2]
  def change
	rename_column :users, :ids, :mail
  end
end
