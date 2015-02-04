RSpec.configure do |config|
  config.add_setting :admin_user, default: "Usuario1"
  config.add_setting :admin_password, default: "Contraseña1"
  config.add_setting :editor_user, default: "Usuario2"
  config.add_setting :editor_password, default: "Contraseña2"
  config.add_setting :public_user, default: "Usuario3"
  config.add_setting :public_password, default: "Contraseña3"
end