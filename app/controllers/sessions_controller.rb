class SessionsController < ApplicationController
  layout "public"
  skip_before_filter :authenticate_user, :only => [:new, :create]

	def new
		redirect_to root_path if @current_user
	end

	def create
		adauth = Adauth.authenticate(params[:username], params[:password])
    if adauth
      session[:current_user] = User.from_ldap(adauth.ldap_object)
      redirect_to root_path, flash: { notice: "Sesión iniciada exitosamente. ¡Bienvenido #{session[:current_user].name}!" }
    else
      redirect_to login_path, flash: { error: "Usuario y/o contraseña incorrectos. Por favor, intente nuevamente." }
    end
	end

	def destroy
    session[:current_user] = nil
		redirect_to login_path
	end
end