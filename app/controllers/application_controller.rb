class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :require_login

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

  def require_login(return_point = request.url)
    if current_person.blank?
      set_return_point(return_point)
      flash[:error] = "You have to log in first"
      redirect_to new_session_path
    end
  end

  def set_return_point(path)
    if session[:return_point].blank?
      session[:return_point] = path
    end
  end

  def return_point
    session[:return_point] || root_path
  end
end
