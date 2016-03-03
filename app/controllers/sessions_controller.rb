class SessionsController < ApplicationController
  skip_before_filter :require_login

  def new
    render 'new'
  end

  def show
    redirect_to new_session_path
  end

  def create
    user = Account.authenticate(account_params[:email], account_params[:password])
    if user.present?
      session[:current_user_id] = user.id
      redirect_to return_point, notice: "You have successfully logged in."
    else
      flash.now[:error] = "Your credentials are invalid. Try again"
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "You have successfully logged out."
  end

  private

  def account_params
    params.require(:session).permit(:email, :password)
  end
end
