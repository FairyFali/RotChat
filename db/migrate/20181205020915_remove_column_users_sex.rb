class RemoveColumnUsersSex < ActiveRecord::Migration[5.2]
  def change
  	remove_column :users, :sex
  end
end
