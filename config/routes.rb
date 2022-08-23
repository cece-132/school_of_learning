Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/teachers', to: 'teachers#index'
  get '/teachers/:teacher_id', to: 'teachers#show'
end
