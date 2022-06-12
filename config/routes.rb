Rails.application.routes.draw do
  devise_for :users,
             controllers: { sessions: 'users/sessions', registrations: 'users/registrations' },
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout' },
             only:        %i[sessions registrations]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "links#index"
  resources :links
  get '/:shorten_code', to: 'clicks#show'
end
