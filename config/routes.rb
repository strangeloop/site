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



Conf::Application.routes.draw do
  resource :attendee, :only => [:edit]
  resources :attendees, :only => [:index]
  resources :talks

  get 'attendees/current'
  put 'attendees/toggle_session'
  put 'attendees/update'
  get '/attendees/:id', :to => 'attendees#show', :as => :attendee

  match '/media/*dragonfly', :to => Dragonfly[:strangeloop]
  post 'reg_online/callback', :to => "reg_online#create"

  match '/blog/:year/:month/:day/:id' => redirect('/news/%{year}/%{month}/%{day}/%{id}')
  match '/news/:year/:month/:day/:id' => 'news_items#show'
  match '/blog/stloopadm' => redirect('/news')
  match '/blog' => redirect('/news')

  match '/auth/:service/callback' => 'services#create' 
  resources :services, :only => [:index, :create, :destroy]

  resources :account_activation

end
