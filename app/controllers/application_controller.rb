class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_person
  helper_method :show_current_controller

  private

  def current_person
    Person.new(first_name: "Janusz", last_name: "Iksiński" )
    @current_person ||= Person.first
  end

  def show_current_controller
    controller_name.gsub('_', ' ').capitalize
  end
end
