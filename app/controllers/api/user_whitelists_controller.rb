class Api::UserWhitelistsController < ApplicationController

  def index
    @user_whitelists = UserWhitelist.all

    render :index
  end

  def create
    @user_whitelist = UserWhitelist.create!(user_whitelist_params)
    render :show
  end


  private

  def user_whitelist_params
    params.require(:user_whitelist).permit(:email)
  end

end
