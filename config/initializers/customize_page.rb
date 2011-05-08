Rails.configuration.after_initialize do
  require 'customized_page'

  PageCustomizer.load
end
