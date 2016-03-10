class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :require_login
  before_filter :set_locale

  helper_method :current_person
  helper_method :show_current_controller

  private

  def set_locale
    I18n.locale = params[:locale] ||
                  session[:locale] ||
                  extract_locale_from_accept_language_header ||
                  I18n.default_locale
    session[:locale] = I18n.locale
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  def current_person
    return nil unless session[:current_user_id]
    @current_user ||= Account.find_by(id: session[:current_user_id]).person
  end

  def show_current_controller
    controller_name.gsub('_', ' ').capitalize
  end

  def require_login(return_point = request.url)
    if current_person.blank?
      set_return_point(return_point)
      flash[:error] = t('errors.restricted')
      redirect_to login_path
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
