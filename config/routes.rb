Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books
      resources :users
      get "followings", to: "relationships#followings"
      get "followers", to: "relationships#followers"
      put "follow", to: "relationships#create"
      patch "follow", to: "relationships#accept"
      delete "follow", to: "relationships#deny"
    end
  end
  match '*path' => 'options_request#response_preflight_request', via: :options
end
