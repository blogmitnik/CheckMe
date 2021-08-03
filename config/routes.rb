Rails.application.routes.draw do
	resources :bin_reports, only: [:index]

	root 'bin_reports#index'
end
