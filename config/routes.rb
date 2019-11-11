Rails.application.routes.draw do

  resources :todos do
    get :change_status, on: :member
    collection do
      get :report_parameters, to: "todos#report_parameters"
      get :generate_report, to: "todos#generate_report"
    end
  end
  devise_for :users
  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
