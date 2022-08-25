Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/teachers', to: 'teachers#index'
  get '/teachers/new', to: 'teachers#new'
  get '/teachers/:teacher_id', to: 'teachers#show'

  get '/teachers/:teacher_id/students', to: 'teacher_students#index'

  get '/students', to: 'students#index'
  get '/students/:student_id', to: 'students#show'

end
