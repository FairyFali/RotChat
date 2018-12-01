class AddReqNumToMachines < ActiveRecord::Migration[5.2]
  def change
  	add_column :machines, :req_num, :integer
  end
end
