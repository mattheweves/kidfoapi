class CreateKids < ActiveRecord::Migration[5.0]
  def change
    create_table :kids do |t|
      t.string :name
      t.date :birthdate
      t.string :gender
      t.string :insuranceprovider

      t.string :bedtime
      t.text :sleeproutine
      t.text :eatdetails

      t.string :allergies

      t.string :nonos

      t.integer :family_id
      t.timestamps
    end
      add_index :kids, :family_id
  end
end
