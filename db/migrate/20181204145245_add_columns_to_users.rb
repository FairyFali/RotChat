class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :nickname, :string
  	add_column :users, :img_url, :string
  	# 个性签名
  	add_column :users, :memo, :string
  	# 性别，0为男，1为女
  	add_column :users, :sex, :integer
  	add_column :users, :birthdate, :datetime
  	# 职业
  	add_column :users, :profession, :string
  	# 家庭住址
  	add_column :users, :address, :string
  	add_column :users, :company, :string
  	# 毕业院校
  	add_column :users, :university, :string
  	add_column :users, :phone, :string

  end
end
