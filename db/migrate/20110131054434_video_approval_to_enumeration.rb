class VideoApprovalToEnumeration < ActiveRecord::Migration
  def self.up
    add_column :talks, :video_approval, :string
  end

  def self.down
    remove_column :talks, :video_approval
  end
end
