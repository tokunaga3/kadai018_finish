class Participation < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :participation, :boolean, default: false
  end
end
