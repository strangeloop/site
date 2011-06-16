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
  resources :conference_sessions, :path => '/sessions', :only => [:index, :show]

  match '/schedule', :controller => 'conference_sessions', :action => :schedule

  match 'archive/*year', :controller => 'conference_sessions', :action => :index

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :conference_sessions, :except => :show do
      collection do
        post :update_positions
        get 'export/:year', :action => :export, :as => 'export'
      end
    end

    resources :rooms
    resources :session_times
  end
end
