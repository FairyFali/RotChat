class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :machineMessages
  has_and_belongs_to_many :machines
  has_and_belongs_to_many :chats
  has_many :messages
  
  def admin?
    self.role == "admin"
  end

end
