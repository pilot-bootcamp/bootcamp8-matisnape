class SessionsController < ApplicationController
  skip_before_filter :require_login

  def new
    render 'new'
  end

  def show
    redirect_to login_path
  end

  def create
    authenticate_user
    check_user_presence
  end

  def destroy
    reset_session
    redirect_to root_url, notice: t('user.form.logout_success')
  end

  def failure
    redirect_to root_url, notice: t('user.form.login_fail')
  end

  private

  def account_params
    params.require(:session).permit(:email, :password)
  end

  def authenticate_user
    if request.env["omniauth.auth"].present?
      @user = FacebookAccount.find_or_create_for_facebook(env["omniauth.auth"])
      session[:account_type] = "facebook_account"
    else
      @user = Account.authenticate(account_params[:email], account_params[:password])
      session[:account_type] = "account"
    end
  end

  def check_user_presence
    if @user.present?
      session[:account_id] = @user.id
      redirect_to return_point, notice: t('user.form.login_success')
    else
      flash.now[:error] = t('user.form.login_fail')
      render 'new'
    end
  end
end
