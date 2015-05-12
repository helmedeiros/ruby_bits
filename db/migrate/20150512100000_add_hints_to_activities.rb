class AddHintsToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :hints, :text   # YAML serialized array
    add_column :activities, :difficulty, :integer, default: 1
  end
end
