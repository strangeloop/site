class AddCryptoHelpersToUserMetadata < ActiveRecord::Migration
  def self.up
    add_column :user_metadata, :reg_uid, :string
    add_column :user_metadata, :reg_date, :timestamp
    remove_column :user_metadata, :home_phone
    remove_column :user_metadata, :work_phone
    remove_column :user_metadata, :cell_phone
    remove_column :user_metadata, :dob
    remove_column :user_metadata, :address_1
    remove_column :user_metadata, :address_2
    remove_column :user_metadata, :gender
    remove_column :user_metadata, :postal_code
    remove_column :user_metadata, :company_name
  end

  def self.down
    remove_column :user_metadata, :reg_date
    remove_column :user_metadata, :reg_uid
    add_column :user_metadata, :home_phone, :string
    add_column :user_metadata, :work_phone, :string
    add_column :user_metadata, :cell_phone, :string
    add_column :user_metadata, :dob, :date
    add_column :user_metadata, :address_1, :string
    add_column :user_metadata, :address_2, :string
    add_column :user_metadata, :gender, :string
    add_column :user_metadata, :postal_code, :string
    add_column :user_metadata, :company_name, :string
  end
end
