class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string        :number,    null: false
      t.boolean       :verified,  null: false, default: false
      t.references    :user,      null: false

      t.timestamps
    end

    add_index :phones, [ :number, :verified ], unique: true
    add_index :phones, :verified
  end
end
