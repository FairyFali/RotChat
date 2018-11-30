class CreateMachineMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :machine_messages do |t|
      t.integer :user_id
      t.integer :machine_id
      t.string :text

      t.timestamps
    end
  end
end
