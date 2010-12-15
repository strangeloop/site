class CreateSpeakers < ActiveRecord::Migration
  def self.up
    create_table :speakers do |t|
      t.string :firstName
      t.string :lastName
      t.string :email
      t.string :phone
      t.text :bio
      t.string :city

      t.timestamps
    end
  end

  def self.down
    drop_table :speakers
  end
end
