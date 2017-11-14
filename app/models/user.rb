class User < ApplicationRecord
	validates :name, presence: true
	validates :password, length: {minimum: 3}, presence: true
	validates :email, presence: true
	validates :age, numericality: true, presence: true
	validates :administrator, numericality: true, presence: true, inclusion: { in: 0..1 }
end
