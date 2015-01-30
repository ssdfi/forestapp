class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user
  before_filter :authorize_user

  helper_method :current_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def current_user
    unless @current_user or session[:current_user].nil?
      @current_user = User.new(session[:current_user])
    end
    @current_user
  end

  def authorize_user
    authorize controller_name.classify.constantize.new
  end

  private

  def authenticate_user
    unless current_user
      redirect_to login_path
    end
  end

  def user_not_authorized
    redirect_to (request.referrer || root_path), flash: { error: "Le pedimos disculpas pero su nivel de usuario no permite realizar esta acción." }
  end
end
