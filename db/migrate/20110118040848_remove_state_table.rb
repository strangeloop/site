class RemoveStateTable < ActiveRecord::Migration
  def self.up
    remove_column :speakers, :state_id
    add_column :speakers, :state, :string
    drop_table :states
  end

  def self.down
    add_column :speakers, :state_id, :integer
    remove_column :speakers, :state
    create_table :states do |t|
      t.string   "abbrev"
      t.string   "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
