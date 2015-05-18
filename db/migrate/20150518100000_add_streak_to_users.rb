class AddStreakToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_streak, :integer, default: 0, null: false
    add_column :users, :longest_streak, :integer, default: 0, null: false
    add_column :users, :last_activity_on, :date
  end
end
