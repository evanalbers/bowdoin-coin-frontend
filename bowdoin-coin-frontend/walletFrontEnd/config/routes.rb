Rails.application.routes.draw do

  root "wallet_front_end#index"
  get "/wallet_front_end" => "wallet_front_end#index"
  get "/wallet_front_end" => "wallet_front_end#index"
  get "/wallet_front_end/success" => "wallet_front_end#success"
  get "/wallet_front_end/error" => "wallet_front_end#error"
  get "/wallet_front_end/balance" => "wallet_front_end#balance"
  get "/" => "wallet_front_end#index"
  post "/" => "wallet_front_end#handlePost"
  post "/wallet_front_end/success" => "wallet_front_end#handlePost"
  post "/wallet_front_end/error" => "wallet_front_end#handlePost"
  post "/wallet_front_end/balance" => "wallet_front_end#handlePost"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
