class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!


  #handling 'access denied error'
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  #If you want to be certain authorization is not forgotten in some controller action
  #check_authorization :unless => :devise_controller? doesn't work as expected

end
