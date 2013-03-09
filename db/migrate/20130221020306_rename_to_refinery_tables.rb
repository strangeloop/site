class RenameToRefineryTables < ActiveRecord::Migration
  def up
    rename_table :users, :refinery_users
    add_column :refinery_users, :reset_password_sent_at, :datetime
    add_index :refinery_users, :id

    rename_table :user_plugins, :refinery_user_plugins
    add_index :refinery_user_plugins, :name
    add_index :refinery_user_plugins, [:user_id, :name], :unique => true

    rename_table :roles, :refinery_roles

    rename_table :roles_users, :refinery_roles_users
    add_index :refinery_roles_users, [:role_id, :user_id]
    add_index :refinery_roles_users, [:user_id, :role_id]

    rename_table :pages, :refinery_pages
    add_index :refinery_pages, :depth
    add_index :refinery_pages, :lft
    add_index :refinery_pages, :parent_id
    add_index :refinery_pages, :rgt

    rename_table :page_translations, :refinery_page_translations
    add_index :refinery_page_translations, :page_id
    add_index :refinery_page_translations, :locale

    rename_table :page_parts, :refinery_page_parts
    add_index :refinery_page_parts, :page_id

    rename_table :page_part_translations, :refinery_page_part_translations
    add_index :refinery_page_part_translations, :locale
    add_index :refinery_page_part_translations, :page_part_id

  end

  def down
    rename_table :refinery_page_part_translations, :page_part_translations

    rename_table :refinery_page_parts, :page_parts

    rename_table :refinery_page_translations, :page_translations

    rename_table :refinery_pages, :pages

    rename_table :refinery_roles_users, :roles_users

    rename_table :refinery_roles, :roles

    rename_table :refinery_user_plugins, :user_plugins

    remove_column :refinery_users, :reset_password_sent_at
    rename_table :refinery_users, :users
    add_index :users, :id
  end
end
