class UserMetadata < ActiveRecord::Base
  
  belongs_to :user
  [:first_name, :last_name, :email, :reg_id, :reg_status].each do |field|
    validates field, :presence => true
  end
  
end
