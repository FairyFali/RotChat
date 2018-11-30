class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.string :name
      t.string :desc
      t.integer :admin_id

      t.timestamps
    end
  end
end
