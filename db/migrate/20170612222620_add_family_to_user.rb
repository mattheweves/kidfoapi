class AddFamilyToUser < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :users, :families
  end
end
