#- Copyright 2011 Strange Loop LLC
#-
#- Licensed under the Apache License, Version 2.0 (the "License");
#- you may not use this file except in compliance with the License.
#- You may obtain a copy of the License at
#-
#-    http://www.apache.org/licenses/LICENSE-2.0
#-
#- Unless required by applicable law or agreed to in writing, software
#- distributed under the License is distributed on an "AS IS" BASIS,
#- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#- See the License for the specific language governing permissions and
#- limitations under the License.
#-



Refinery::Core::Engine.routes.draw do
  resources :proposals, :only => [:new, :create]

  get '/proposals/new/:format' => 'proposals#new', :as => :new_proposal_of

  namespace :admin, path: 'refinery' do
    resources :proposals, :except => :show do
      collection do
        post :update_positions
        get 'export/pending', :action => :export, :as => 'export'
      end

      get '/refinery/proposals/:format' => 'admin::proposals#index'

      post :rate, :on => :member
      post :add_comment, :on => :member
      post :proposal_update, :on => :member
    end
  end
end
