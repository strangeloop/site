class UserMetadata < ActiveRecord::Base
  
  belongs_to :user
  ModelUtils.validate_presence [:first_name, :last_name, :email, :reg_id, :reg_status]
  
end
