class AddFormatToProposal < ActiveRecord::Migration
  def self.up
    add_column :proposals, :format, :string
  end

  def self.down
    remove_column :proposals, :format
  end
end
