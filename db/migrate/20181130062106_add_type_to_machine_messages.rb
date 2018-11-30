class AddTypeToMachineMessages < ActiveRecord::Migration[5.2]
  def change
  	add_column :machine_messages, :type2, :integer
  end
end
