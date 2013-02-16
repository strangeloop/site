# This migration comes from refinery_news (originally 20110817203702)
class RenameNewsItemsToRefineryNewsItems < ActiveRecord::Migration

  def up
    rename_table :news_items, ::Refinery::News::Item.table_name
  end

  def down
    rename_table ::Refinery::News::Item.table_name, :news_items
  end
end
