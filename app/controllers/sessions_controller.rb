class SessionsController < ApplicationController

  def new
    render 'new'
  end

  def create
    user = Account.find_by(account_params)
    if user.present?
      session[:current_user_id] = user.id
      redirect_to root_url, notice: "You have successfully logged in."
    end
  end

  private

  def account_params
    params.require(:session).permit(:email, :password)
  end
end
