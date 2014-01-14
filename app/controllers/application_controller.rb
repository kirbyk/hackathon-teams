class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  enable_authorization do |exception|
    redirect_to root_url, :notice => exception.message
  end unless :devise_controller?
end
