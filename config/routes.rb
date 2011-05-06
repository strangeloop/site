Conf::Application.routes.draw do
  resources :talks
  match '/media/*dragonfly', :to => Dragonfly[:strangeloop]
  post 'reg_online/callback', :to => "reg_online#create"

  match '/blog/:year/:month/:day/:id' => redirect('/news/%{year}/%{month}/%{day}/%{id}')
  match '/news/:year/:month/:day/:id' => 'news_items#show'
end
