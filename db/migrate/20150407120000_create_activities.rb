class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :lesson,   null: false, index: true, foreign_key: true
      t.string  :title,       null: false
      t.string  :kind,        null: false, default: 'code'   # 'code' or 'choice'
      t.text    :prompt
      t.text    :starter_code
      t.text    :solution
      t.text    :spec_code     # ruby test asserting expected behavior
      t.text    :choices       # YAML for choice activities
      t.string  :correct_choice
      t.integer :position,    default: 0
      t.timestamps null: false
    end
  end
end
