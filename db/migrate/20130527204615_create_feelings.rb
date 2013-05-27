class CreateFeelings < ActiveRecord::Migration
  def change
    create_table :feelings do |t|
      t.references  :user,      :null => false
      t.string      :source,    :null => false
      t.string      :event_id,  :null => false
      t.integer     :score,     :null => false

      t.timestamps
    end

    add_index :feelings, :user_id
    add_index :feelings, :source
    add_index :feelings, :event_id
  end
end
