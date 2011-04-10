class CreateUserMetadata < ActiveRecord::Migration
  def self.up
    create_table :user_metadata do |t|
      t.references :user
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date :dob
      t.string :address_1
      t.string :address_2
      t.string :gender
      t.string :city
      t.string :region
      t.string :country
      t.string :postal_code
      t.string :home_phone
      t.string :work_phone
      t.string :cell_phone
      t.string :email
      t.string :company_name
      t.string :twitter_id
      t.string :blog_url
      t.string :reg_id
      t.string :reg_status
      t.timestamps
    end
  end

  def self.down
    drop_table :user_metadata
  end
end
