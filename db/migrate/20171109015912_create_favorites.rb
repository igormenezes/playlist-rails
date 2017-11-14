class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.string :name
      t.string :style
      t.string :artist
      t.references :users, foreign_key: true
      t.references :musics, foreign_key: true

      t.timestamps
    end
  end
end
