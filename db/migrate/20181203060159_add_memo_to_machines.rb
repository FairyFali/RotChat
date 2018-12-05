class AddMemoToMachines < ActiveRecord::Migration[5.2]
  def change
  	add_column :machines, :memo, :string
  end
end
