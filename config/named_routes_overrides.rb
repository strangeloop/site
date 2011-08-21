Rails.application.routes.draw do
  devise_for :users,
   :only => :sign_in,
  :path_names => {:sign_in => 'login', :sign_up => 'activation'},
   :path => '',
   :controllers => {:sign_in => 'attendee_login/create', :sign_up => 'account_activation/create'} do

  #any additional user session routes would be defined here
  end

  get "static/home", :as=>"user_root"
end

