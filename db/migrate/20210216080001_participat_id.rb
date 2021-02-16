class ParticipatId < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :participat_id, :integer
  end
end
