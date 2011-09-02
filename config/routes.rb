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


  devise_for :attendee_creds, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => 'attendee_cred/registrations' } do
    # google callbacks are going to the wrong place.  They are going to the url below when they should be going
    # through the auth/:provider path.  I think this is due to https://github.com/intridea/omniauth/issues/138.
    # We can't upgrade Devise unless we upgrade Refinery, this hack gets around the issue.
    match 'attendee_creds/auth/google/callback' => 'omniauth_callbacks#google'
    get '/attendee_creds/auth/:provider' => 'omniauth_callbacks#passthru', :as => :external_auth
    get '/login' => 'devise/sessions#new', :as => :new_attendee_session
    get '/logout' => 'devise/sessions#destroy', :as => :destroy_attendee_session
    get '/activation/:token', :to => 'devise/registrations#new', :as => :activation
  end

  resource :attendee, :only => [:edit]
  resources :attendees, :only => [:index]
  resources :talks

  put 'attendees/update'
  get '/attendees/:id', :to => 'attendees#show', :as => :attendee

  match '/media/*dragonfly', :to => Dragonfly[:strangeloop]

  match '/blog/:year/:month/:day/:id' => redirect('/news/%{year}/%{month}/%{day}/%{id}')
  match '/news/:year/:month/:day/:id' => 'news_items#show'
  match '/blog/stloopadm' => redirect('/news')
  match '/blog' => redirect('/news')



end
