PlatformdirectoryCom::Application.routes.draw do
  match '/list' => 'landing#list', :as => :list
  match '/filter' => 'landing#filter', :as => :filter
  match '/about' => 'landing#about', :as => :about
  match ':slug' => 'landing#detail', :as => :detail
  match ':platform/:country' => 'landing#list', :as => :filteredlist

  root :to => 'landing#index'
end
