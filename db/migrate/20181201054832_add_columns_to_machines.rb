class AddColumnsToMachines < ActiveRecord::Migration[5.2]
  def change
  	add_column :machines, :score, :integer
  	add_column :machines, :duration, :integer
  	add_column :machines, :code, :integer
  end
end
