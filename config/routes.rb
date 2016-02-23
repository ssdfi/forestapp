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
        get 'report', path: 'reporte'
      end
    end

    resources :plantaciones do
      put 'replace', path: 'reemplazar'
      get 'map', path: 'mapa'
      collection do
        get 'mass_edit', path: 'editar'
        put 'mass_update', path: 'actualizar'
      end
      resources :validaciones
    end

    resources :zonas do
      resources :zona_departamentos
    end

    resources :provincias do
      resources :departamentos
    end

    resources :especies, only: [:index], constraints: { format: 'json' }
    resources :generos do
      resources :especies
    end

    resources :titulares
    resources :tecnicos

    get "/login" => "sessions#new"
    get "/logout" => "sessions#destroy"
    post "/adauth" => "sessions#create"
  end
end
