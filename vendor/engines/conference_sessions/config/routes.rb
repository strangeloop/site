Refinery::Application.routes.draw do
  resources :conference_sessions, :path => '/sessions', :only => [:index, :show]

  match "archive/*year", :controller => 'conference_sessions', :action => :index

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :conference_sessions, :except => :show do
      collection do
        post :update_positions
      end
    end
  end
end
