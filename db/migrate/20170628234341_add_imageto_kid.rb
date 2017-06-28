class AddImagetoKid < ActiveRecord::Migration[5.0]
  def change
    add_column :kids, :image, :string
  end
end
