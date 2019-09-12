class AddDetailsToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :country, :string
    add_column :profiles, :state, :string
    add_column :profiles, :city, :string
    add_column :profiles, :postal_code, :string
    add_column :profiles, :address, :text
    add_column :profiles, :phone_number, :string
    add_column :profiles, :user_description, :text
  end
end
