class RemovePicturefromKids < ActiveRecord::Migration[5.0]
  def change
    remove_column :kids, :picture
  end
end
