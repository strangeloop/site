class ChangeServicesAssociationToAttendeeCred < ActiveRecord::Migration
  def self.up
    change_table :services do |t|
      t.remove_references :user
      t.references :attendee_cred
    end
  end

  def self.down
    change_table :services do |t|
      t.references :user
      t.remove_references :attendee_cred
    end
  end
end
