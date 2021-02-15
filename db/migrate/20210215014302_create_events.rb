class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.datetime :date,null: false
      t.string :title,null: false
      t.text :content,null: false
      t.string :start_point,null: false
      t.string :goal_point,null: false
      t.integer :carry_price,null: false
      t.integer :status,null: false




      t.timestamps
    end
  end
end
