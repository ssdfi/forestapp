Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'expedientes#index'

  scope(path_names: { new: 'crear', edit: 'editar' }) do
    resources :expedientes do
      resources :movimientos do
        resources :actividades do
          get 'map', path: 'mapa'
        end
      end
    end

    resources :plantaciones do
      put 'replace', path: 'reemplazar'
      get 'map', path: 'mapa'
    end

    resources :zonas do
      resources :departamentos
    end

    resources :especies
    resources :generos
    resources :titulares
    resources :tecnicos

    resources :sessions
    get "/login" => "sessions#new"
    get "/logout" => "sessions#destroy"
    post "/adauth" => "sessions#create"
  end
end
