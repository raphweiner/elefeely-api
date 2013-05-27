class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.string        :number,    :null => false
      t.boolean       :verified,  :null => false, :default => false
      t.references    :user,      :null => false

      t.timestamps
    end

    add_index :phone_numbers, [ :number, :verified ], unique: true
    add_index :phone_numbers, :verified
  end
end
