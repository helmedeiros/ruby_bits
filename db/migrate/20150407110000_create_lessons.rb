class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.references :learning_module, null: false, index: true, foreign_key: true
      t.string :title,        null: false
      t.string :slug,         null: false
      t.text   :body
      t.integer :position,    default: 0
      t.timestamps null: false
    end
    add_index :lessons, [:learning_module_id, :slug], unique: true, name: 'idx_lessons_on_module_slug'
  end
end
