class CreateLearningModules < ActiveRecord::Migration
  def change
    create_table :learning_modules do |t|
      t.references :track,    null: false, index: true, foreign_key: true
      t.string  :name,        null: false
      t.string  :slug,        null: false
      t.text    :overview
      t.integer :position,    default: 0
      t.timestamps null: false
    end
    add_index :learning_modules, [:track_id, :slug], unique: true
  end
end
