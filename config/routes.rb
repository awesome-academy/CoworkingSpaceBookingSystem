Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
<<<<<<< HEAD
=======
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    root "static_pages#home"
    get  "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users
>>>>>>> 2098788... View_Edit_Profile
  end
end
