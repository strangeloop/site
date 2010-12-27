class CreateSpeakers < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.string :abbrev
      t.string :description
      t.timestamps
    end

    create_table :speakers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.text :bio
      t.references :state
      t.timestamps
    end

    create_table :talk_types do |t|
      t.string :name
      t.string :description
      t.timestamps
    end

    create_table :talk_lengths do |t|
      t.string :description
      t.timestamps
    end

    create_table :video_approvals do |t|
      t.string :description

      t.timestamps
    end

    create_table :tracks do |t|
      t.string :abbrev
      t.string :description
      t.timestamps
    end

    create_table :talks do |t|
      t.string :title
      t.text :abstract
      t.text :prereqs
      t.text :comments
      t.text :av_requirement
      t.references:talk_type
      t.references :talk_length
      t.references :video_approval
      t.references :track
      t.timestamps
    end

    create_table :speakers_talks, :id => false do |t|
      t.references :speaker
      t.references :talk
    end
  end

  def self.down
    drop_table :states
    drop_table :speakers
    drop_table :talk_types
    drop_table :talk_lengths
    drop_table :video_approvals
    drop_table :tracks
    drop_table :talks
    drop_table :speakers_talks
  end
end
