class Machine < ApplicationRecord
	has_many :machineMessages
	has_and_belongs_to_many :users
end
