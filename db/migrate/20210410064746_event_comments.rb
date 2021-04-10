class EventComments < ActiveRecord::Migration[5.2]
  def change
    create_table :event_comments do |t|
      t.string :comment,null: false

    end
    add_reference :event_comments, :event, foreign_key: true
  end
end
