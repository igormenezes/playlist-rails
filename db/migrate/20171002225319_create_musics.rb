class CreateMusics < ActiveRecord::Migration[5.1]
  def change
    create_table :musics do |t|
      t.string :name
      t.string :style
      t.string :artist

      t.timestamps
    end
  end
end
