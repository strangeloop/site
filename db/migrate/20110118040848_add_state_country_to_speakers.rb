class AddStateCountryToSpeakers < ActiveRecord::Migration
  def self.up
    add_column :speakers, :state, :string
    add_column :speakers, :country, :string    
  end

  def self.down
    remove_column :speakers, :country
    remove_column :speakers, :state
  end
end
