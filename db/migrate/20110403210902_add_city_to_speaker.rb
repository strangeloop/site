class AddCityToSpeaker < ActiveRecord::Migration
  def self.up
    add_column :speakers, :city, :string
  end

  def self.down
    remove_column :speakers, :city
  end
end
