class AddBolgIdToMachine < ActiveRecord::Migration[5.2]
  def change
  	add_column :machines, :bolg_id, :integer
  end
end
