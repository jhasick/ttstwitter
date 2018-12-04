Rails.application.routes.draw do
  get 'show_user/:id' => "epicenter#show_user", as: "show_user"
  get 'now_following' => "epicenter#now_following"
  get 'unfollow' => "epicenter#unfollow"
  get 'tag_tweets' => "epicenter#tag_tweets"
  devise_for :views
  resources :tweets
  devise_for :users

  root "epicenter#feed"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
