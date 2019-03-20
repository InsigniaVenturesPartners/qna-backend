class Api::V1::UserWhitelistsController < Api::V1::BaseController
  def index
    user_whitelists = UserWhitelist.all

    user_whitelists = user_whitelists.paginate(page: params[:page], per_page: params[:per_page] || 25)
    render_json_paginate(user_whitelists, root: :user_whitelists)
  end

  def create
    user_whitelist = UserWhitelist.create!(user_whitelist_params)
    render_created(presenter_json(user_whitelist))
  end

  private

  def user_whitelist_params
    params.require(:user_whitelist).permit(:email)
  end
end
