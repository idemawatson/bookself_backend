Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books
    end
  end
  match '*path' => 'options_request#response_preflight_request', via: :options
end
