class AddCompanyToUserMetadata < ActiveRecord::Migration
  def self.up
    add_column :user_metadata, :company, :string
    add_column :user_metadata, :state, :string
    remove_column :user_metadata, :region
  end

  def self.down
    remove_column :user_metadata, :company
    remove_column :user_metadata, :state    
    add_column :user_metadata, :region, :string
  end
end
