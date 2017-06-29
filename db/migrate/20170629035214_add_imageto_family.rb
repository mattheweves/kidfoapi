class AddImagetoFamily < ActiveRecord::Migration[5.0]
  def change
    add_column :families, :image, :string
  end
end
