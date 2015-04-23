class CreateCompletions < ActiveRecord::Migration
  def change
    create_table :completions do |t|
      t.references :user,     null: false, index: true, foreign_key: true
      t.references :lesson,   null: false, index: true, foreign_key: true
      t.datetime :completed_at, null: false
    end
    add_index :completions, [:user_id, :lesson_id], unique: true
  end
end
