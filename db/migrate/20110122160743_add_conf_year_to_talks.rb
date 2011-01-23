class AddConfYearToTalks < ActiveRecord::Migration
  def self.up
    add_column :talks, :conf_year, :integer
  end

  def self.down
    remove_column :talks, :conf_year
  end
end
