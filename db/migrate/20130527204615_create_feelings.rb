class CreateFeelings < ActiveRecord::Migration
  def change
    create_table :feelings do |t|
      t.references  :user,             null: false
      t.references  :source,           null: false
      t.string      :source_event_id,  null: false
      t.integer     :score,            null: false

      t.timestamps
    end

    add_index :feelings, :user_id
    add_index :feelings, [ :source_id, :source_event_id ], unique: true
    add_index :feelings, :source_event_id
  end
end
