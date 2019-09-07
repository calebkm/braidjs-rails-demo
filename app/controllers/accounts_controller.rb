class AccountsController < ApplicationController
  def index
    @accounts = Account.all

    respond_to do |f|
      f.html
      f.json { render json: @accounts }
    end
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)

    respond_to do |f|
      if @account.save
        f.html
        f.json { render json: @account }
      else
        f.html
        f.json { render json: @account } # Errors?
      end
    end
  end

  def show
    @account = find_account

    respond_to do |f|
      f.html
      f.json { render json: @account }
    end
  end

  def update
    @account = find_account

    respond_to do |f|
      if @account.update_attributes(account_params)
        f.html
        f.json { render json: @account }
      else
        f.html
        f.json { render json: @account } # Errors?
      end
    end
  end

  def destroy
    find_account.destroy

    respond_do do |f|
      f.html
      f.json { render json: '' } # what goes here?
    end
  end

private

  def find_account
    Account.where(id: params[:id]).first
  end

  def account_params
    params.require(:account).permit(:name, :type)
  end
end
