# This customizes the User model defined in the refinery-
# authentication plugin.  We have to do it this way bc
# Rails needs to load the model first and the below 
# customizations are triggered after Rails has finished
# loading the app in an after_initialize callback.
class UserCustomizer

  def self.load
    User.class_eval do
      ajaxful_rater
    end
  end
end
