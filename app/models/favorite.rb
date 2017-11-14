class Favorite < ApplicationRecord
	validates :name, presence: true
	validates :style, presence: true
	validates :artist, presence: true
	validates :users_id, presence: true
	validates :musics_id, presence: true
end
