Rails.application.routes.draw do
  devise_for :users,

  :path_names => {:sign_in => 'login', :sign_up => 'activation'},
  :path => '',
  :controllers => {:sign_up => 'account_activation/create'} do

  #any additional user session routes would be defined here
  end

  get "attendees/index", :as=>"root"
end

