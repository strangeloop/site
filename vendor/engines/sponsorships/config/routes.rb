Refinery::Application.routes.draw do
  resources :sponsorships, :only => [:index, :show]

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :sponsorships, :except => :show do
      collection do
        post :update_positions
      end
    end
    resources :sponsorship_levels
  end
end
