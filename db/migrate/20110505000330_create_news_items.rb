class CreateNewsItems < ActiveRecord::Migration

  def self.up
    create_table :news_items, :id => true do |t|
      t.string :title
      t.text :body
      t.datetime :publish_date
      t.integer :image_id
      t.string :external_url
      t.timestamps
    end

    add_index :news_items, :id

    
    NewsItem.create_translation_table! :title => :string, :body => :text, :external_url => :string
  end

  def self.down
    UserPlugin.destroy_all({:name => "refinerycms_news"})

    Page.delete_all({:link_url => "/news"})

    NewsItem.drop_translation_table!

    drop_table :news_items
  end

end
