Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "workbook_sessions#new"
  resources :workbook_sessions do
    resources :thinking_traps, only: [ :create ]
  end

  mount RubyLLM::Evals::Engine, at: "/evals"
end
