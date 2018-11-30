class CreateTableUsersMachines < ActiveRecord::Migration[5.2]
  def change
    create_table :users_machines, :id => false do |t|
    	t.column "user_id", :integer, :null => false
        t.column "machine_id",  :integer, :null => false
    end
  end
end
