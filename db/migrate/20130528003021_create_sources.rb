class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string      :name,   null: false
      t.string      :key,    null: false
      t.string      :secret, null: false

      t.timestamps
    end
    add_index :sources, :key, unique: true
  end
end
