class RemoveCountriesTable < ActiveRecord::Migration
  def self.up
    remove_column :speakers, :country_id
    add_column :speakers, :country, :string
    drop_table :countries
  end

  def self.down
    create_table :countries do |t|
      t.string   "abbrev"
      t.string   "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_column :speakers, :country_id, :integer
    remove_column :speakers, :country

  end
end
