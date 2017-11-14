class Music < ApplicationRecord
	validates :name, presence: true
	validates :style, presence: true
	validates :artist, presence: true
end
