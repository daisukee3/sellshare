class AddTypeToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :type, :integer
  end
end
