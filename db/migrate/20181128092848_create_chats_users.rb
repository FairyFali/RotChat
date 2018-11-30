class CreateChatsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :chats_users do |t|
    	t.integer :user_id, :null => false
    	t.integer :chat_id, :null => false
    end
  end
end
