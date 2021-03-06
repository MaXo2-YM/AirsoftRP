Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'pages#home'

	get 'users' => 'users#index'
	get 'users/:id' => 'users#show'
    get 'signup' => 'users#new'
	get 'users/:id/edit' => 'users#edit'

    get 'characters/:id' => 'characters#show'
	get 'tchoin' => 'pages#test'

	post 'users' => 'users#create'
    post 'characters' => 'characters#create'
	post 'users/login' => 'users#check'

	patch 'users/:id' => 'users#update'
	patch 'characters/:id' => 'characters#update'

	delete 'users/login' => 'users#logout'
	delete 'users/:id' => 'users#destroy'
    delete 'characters/:id' => 'characters#destroy'

end
