# Tip for speeding up tests from Devise wiki
Devise.setup do |config|
  config.stretches = Rails.env.test? ? 1 : 10
end
