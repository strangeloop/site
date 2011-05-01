class AddConfYearMigration < ActiveRecord::Migration
  def self.up
    add_column :speakers, :conf_year, :integer
  end

  def self.down
    remove_column :speakers, :conf_year
  end
end
