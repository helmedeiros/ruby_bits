class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string  :name,        null: false
      t.string  :slug,        null: false
      t.text    :description
      t.integer :position,    default: 0
      t.timestamps null: false
    end
    add_index :tracks, :slug, unique: true
  end
end
