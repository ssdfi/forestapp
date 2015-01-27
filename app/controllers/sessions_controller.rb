class SessionsController < ApplicationController
  skip_before_filter :authenticate_user, :only => [:new, :create]

	def new
		redirect_to root_path if @current_user
	end

	def create
		@current_user = Adauth.authenticate params[:username], params[:password]
    if @current_user
      session[:current_user] = @current_user
      redirect_to root_path, flash: { notice: "Sesión iniciada exitosamente." }
    else
      redirect_to login_path, flash: { error: "Usuario y/o contraseña inválidos." }
    end
	end

	def destroy
    session[:current_user] = nil
		redirect_to login_path, flash: { notice: "¡Hasta luego!" }
	end
end