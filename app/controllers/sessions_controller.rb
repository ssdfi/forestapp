class SessionsController < ApplicationController
  layout 'public'
  skip_before_filter :authenticate_user, :only => [:new, :create]
  skip_before_filter :authorize_user

	##
  # Muestra el formulario de login si no existe un usuario activo
  def new
		redirect_to root_path if @current_user
	end

  ##
  # Genera una nueva sesión a partir de los datos del formulario de login
  #
  # Lo autenticación se hace contra el ActiveDirectory del MAGyP
	def create
		adauth = Adauth.authenticate(params[:username], params[:password])
    if adauth
      session[:current_user] = User.from_ldap(adauth.ldap_object).as_json
      redirect_to root_path, flash: { notice: "Sesión iniciada exitosamente. ¡Bienvenido #{current_user.name}!" }
    else
      redirect_to login_path, flash: { error: "Usuario y/o contraseña incorrectos. Por favor, intente nuevamente." }
    end
	end

  ##
  # Cierra la sesión activa
	def destroy
    session[:current_user] = nil
		redirect_to login_path
	end
end