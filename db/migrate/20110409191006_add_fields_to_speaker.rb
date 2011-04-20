class AddFieldsToSpeaker < ActiveRecord::Migration
  def self.up
    add_column :speakers, :city, :string    
    add_column :speakers, :twitter_id, :string
    add_column :speakers, :company, :string
    add_column :speakers, :company_url, :string
  end

  def self.down
    remove_column :speakers, :twitter_id
    remove_column :speakers, :company
    remove_column :speakers, :company_url
    remove_column :speakers, :city    
  end
end
