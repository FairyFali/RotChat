class CreateMachinesUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :machines_users do |t|
    	t.integer :machine_id, :null => false
    	t.integer :user_id, :null => false
    end
  end
end
