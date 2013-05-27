class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.string        :number,  :null => false
      t.string        :status,  :null => false
      t.references    :user,    :null => false

      t.timestamps
    end

    add_index :phone_numbers, [ :number, :status ], unique: true
    add_index :phone_numbers, :status
  end
end
