Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books
      resources :users
      put "followings", to: "relationships#create"
      delete "followings", to: "relationships#unfollow"
      patch "followreq", to: "relationships#accept"
      delete "followreq", to: "relationships#deny"
      delete "followers", to: "relationships#block"
    end
  end
  match '*path' => 'options_request#response_preflight_request', via: :options
end
