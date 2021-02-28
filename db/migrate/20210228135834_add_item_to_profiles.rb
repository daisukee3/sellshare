class AddItemToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :gender, :integer
    add_column :profiles, :age, :integer
  end
end
