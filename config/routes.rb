Rails.application.routes.draw do
  resources :users do
    # DELETE /users/destroy_all — видалити всіх користувачів
    collection do
      delete :destroy_all
    end
  end

  get "hi/index"

  # Статичні сторінки Wiki
  get "about",       to: "pages#about",       as: :about
  get "quick_start", to: "pages#quick_start", as: :quick_start
  get "api_docs",    to: "pages#api",         as: :api_docs
  get "faq",         to: "pages#faq",         as: :faq

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # Головна сторінка — "Про проєкт"
  root "pages#about"
end
