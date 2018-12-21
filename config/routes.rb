Rails.application.routes.draw do
	root "welcome#welcome"

	devise_for :users

	resources :screams
	resources :solvers
	resources :administrations

	post 'screams/set-filter', to: 'screams#set_filter'
	get 'stats', to: 'stats#index'
end
