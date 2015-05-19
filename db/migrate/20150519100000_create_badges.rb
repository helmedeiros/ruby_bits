class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :slug,  null: false
      t.string :name,  null: false
      t.text   :description
      t.string :icon_glyph, default: '*'
      t.timestamps null: false
    end
    add_index :badges, :slug, unique: true

    create_table :awards do |t|
      t.references :user,  null: false, index: true, foreign_key: true
      t.references :badge, null: false, index: true, foreign_key: true
      t.datetime :awarded_at, null: false
    end
    add_index :awards, [:user_id, :badge_id], unique: true
  end
end
