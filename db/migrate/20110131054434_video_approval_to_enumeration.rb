class VideoApprovalToEnumeration < ActiveRecord::Migration
  def self.up
    remove_column :talks, :video_approval_id
    drop_table :video_approvals
    add_column :talks, :video_approval, :string
  end

  def self.down
    remove_column :talks, :video_approval
    create_table :video_approvals do |t|
      t.string :description
      t.timestamps
    end
    add_column :talks, :references, :video_approval_id
  end
end
