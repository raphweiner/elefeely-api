class RemoveFeelingsUniqueIndexOnSourceIdAndSourceEventId < ActiveRecord::Migration
  def up
    remove_index :feelings, column: [ :source_id, :source_event_id ]
    change_column :feelings, :source_event_id, :string, null: true
  end

  def down
    add_index :feelings, [ :source_id, :source_event_id ], unique: true
    change_column :feelings, :source_event_id, :string, null: false
  end
end
