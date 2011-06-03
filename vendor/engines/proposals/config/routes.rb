Refinery::Application.routes.draw do
  # To publicly show submitted proposals, uncomment the line below
  #resources :proposals, :only => [:index, :show]

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :proposals, :except => :show do
      collection do
        post :update_positions
        get 'export/pending', :action => :export, :as => 'export'
      end

      post :rate, :on => :member
      post :add_comment, :on => :member
      post :proposal_update, :on => :member
    end
  end
end
