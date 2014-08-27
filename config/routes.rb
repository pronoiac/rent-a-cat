RentACat::Application.routes.draw do
  resources :cats
  resource :user
  resource :session
end
