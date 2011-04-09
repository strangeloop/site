[
  {:name => "site_name", :value => "Strange Loop"},
  {:name => "new_page_parts", :value => true, :form_type => 'check_box'},
  {:name => "default_page_parts", :value => ["Top", "Middle", "Bottom"]},
  {:name => "frontend_refinery_stylesheets_enabled", :value => false, :form_type => 'check_box'},
  {:name => "cache_menu", :value => true, :form_type => 'check_box'},
  {:name => "superuser_can_assign_roles", :value => true, :form_type => 'check_box'},
  {:name => "activity_show_limit", :value => 7},
  {:name => "preferred_image_view", :value => :grid},
  {:name => "analytics_page_code", :value => "UA-xxxxxx-x"},
  {:name => "user_image_sizes", :value => {
    :small => '110x110>',
    :medium => '225x255>',
    :large => '450x450>'
    }
  }
].each do |setting|
  RefinerySetting.create(:name => setting[:name].to_s, :value => setting[:value], :destroyable => false, :form_value_type => (setting[:form_type] || 'text_area'))
end
