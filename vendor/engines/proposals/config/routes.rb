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
