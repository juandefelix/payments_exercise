Rails.application.routes.draw do
  resources :loans, defaults: {format: :json} do
    resources :payments, only: [:create, :index, :show], shallow: true, defaults: {format: :json}
  end
end
