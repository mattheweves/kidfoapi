class CreateFamilies < ActiveRecord::Migration[5.0]
  def change
    create_table :families do |t|
      t.string :name
      t.string :avatar
      t.string :emerg_contact_1
      t.string :emerg_contact_1_phone
      t.string :emerg_contact_2
      t.string :emerg_contact_2_phone
      t.string :insuranceprovider
      t.string :health_ins_enrollee_id
      t.string :health_ins_group_num
      t.string :physicianname
      t.string :physicianphone

      t.timestamps
    end
  end
end
