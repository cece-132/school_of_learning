Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/teachers', to: 'teachers#index'
  post '/teachers', to: 'teachers#create'
  get '/teachers/new', to: 'teachers#new'
  get '/teachers/:teacher_id', to: 'teachers#show'
  patch '/teachers/:teacher_id', to: 'teachers#update'
  delete '/teachers/:teacher_id', to: 'teachers#destroy'
  get '/teachers/:teacher_id/edit', to: 'teachers#edit'

  get '/teachers/:teacher_id/students', to: 'teacher_students#index'
  post '/teachers/:teacher_id/students', to: 'teacher_students#create'
  get '/teachers/:teacher_id/students/new', to: 'teacher_students#new'

  get '/students', to: 'students#index'
  get '/students/:student_id', to: 'students#show'
  patch '/students/:student_id', to: 'students#update'
  delete '/students/:student_id', to: 'students#destroy'
  get '/students/:student_id/edit', to: 'students#edit'

end
