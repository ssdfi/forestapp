Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'expedientes#index'

  resources :expedientes do
    resources :movimientos do
      resources :actividades do
        get 'map'
      end
    end
  end

  resources :plantaciones do
    get 'map'
  end

  resources :titulares

end
