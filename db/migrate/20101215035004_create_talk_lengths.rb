class CreateTalkLengths < ActiveRecord::Migration
  def self.up
    create_table :talk_lengths do |t|
      t.string :shortDescrption
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :talk_lengths
  end
end
