class AddUrlToMachines < ActiveRecord::Migration[5.2]
  def change
  	add_column :machines, :url, :string
  end
end
