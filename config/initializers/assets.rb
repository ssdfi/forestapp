# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( map/map.js map/map.css public/public.js public/public.css )
Rails.application.config.assets.precompile += %w(
  expedientes.js
  movimientos.js
  actividades.js
  plantaciones.js
  titulares.js
  tecnicos.js
  zonas.js
  departamentos.js
  generos.js
  especies.js
)
