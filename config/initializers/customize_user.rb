Rails.configuration.after_initialize do
  require 'customized_user'

  UserCustomizer.load
end
