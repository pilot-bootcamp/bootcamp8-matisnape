class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_person
  helper_method :show_current_controller

  private

  def current_person
    @current_user ||= session[:current_user_id] &&
                      Account.find_by(id: session[:current_user_id]).person
  end

  def show_current_controller
    controller_name.gsub('_', ' ').capitalize
  end
end
