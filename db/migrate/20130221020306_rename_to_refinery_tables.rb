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
    add_column :refinery_pages, :slug, :string
    add_column :refinery_pages, :view_template, :string
    add_column :refinery_pages, :layout_template, :string
    remove_column :refinery_pages, :position
    remove_column :refinery_pages, :custom_title_type
    add_index :refinery_pages, :depth
    add_index :refinery_pages, :lft
    add_index :refinery_pages, :parent_id
    add_index :refinery_pages, :rgt

    rename_table :page_translations, :refinery_page_translations
    rename_column :refinery_page_translations, :page_id, :refinery_page_id
    add_index :refinery_page_translations, :refinery_page_id
    add_index :refinery_page_translations, :locale

    rename_table :page_parts, :refinery_page_parts
    rename_column :refinery_page_parts, :page_id, :refinery_page_id
    add_index :refinery_page_parts, :refinery_page_id

    rename_table :page_part_translations, :refinery_page_part_translations
    rename_column :refinery_page_part_translations, :page_part_id, :refinery_page_part_id
    add_index :refinery_page_part_translations, :locale
    add_index :refinery_page_part_translations, :refinery_page_part_id

    rename_table :images, :refinery_images

    rename_table :resources, :refinery_resources
  end

  def down
    rename_table :refinery_resources, :resources

    rename_table :refinery_images, :images

    rename_table :refinery_page_part_translations, :page_part_translations
    rename_column :page_part_translations, :refinery_page_part_id, :page_part_id

    rename_table :refinery_page_parts, :page_parts
    rename_column :page_parts, :refinery_page_id, :page_id

    rename_table :refinery_page_translations, :page_translations
    rename_column :page_translations, :refinery_page_id, :page_id

    rename_table :refinery_pages, :pages
    remove_column :pages, :slug
    remove_column :pages, :view_template
    remove_column :pages, :layout_template
    add_column :pages, :position, :integer
    add_column :pages, :custom_title_type, :string, default: 'none'

    rename_table :refinery_roles_users, :roles_users

    rename_table :refinery_roles, :roles

    rename_table :refinery_user_plugins, :user_plugins

    remove_column :refinery_users, :reset_password_sent_at
    rename_table :refinery_users, :users
    add_index :users, :id
  end
end
