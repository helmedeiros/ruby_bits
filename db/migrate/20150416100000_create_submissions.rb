class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :activity, null: false, index: true, foreign_key: true
      t.references :user,     index: true
      t.text    :source
      t.string  :choice
      t.string  :status,      default: 'pending'   # pending, passed, failed, error
      t.text    :stdout
      t.text    :stderr
      t.float   :runtime_ms
      t.timestamps null: false
    end
  end
end
