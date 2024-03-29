class AccountsController < ApplicationController
  skip_before_filter :require_login

  def new
    if current_person.blank?
      @account = Account.new
    else
      redirect_to root_path
    end
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      flash[:success] = t('user.form.success_msg')
      redirect_to login_path
      UserMailer.welcome_email(@account).deliver_now
    else
      flash.now[:error] = t('user.form.failed_msg')
      render 'new'
    end
  end

  private

  def account_params
    params.require(:account).permit(:email, :password, :password_confirmation, :person, person_attributes: [:first_name, :last_name])
  end

  def account
    @account ||= Account.find(params[:id])
  end
end
