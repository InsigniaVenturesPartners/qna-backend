class Api::V1::BaseController < ApplicationController
  respond_to :json
  before_action :authenticate

  def current_user
    @user
  end

  protected

  def authenticate
    authenticate_internal_token || authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      @user = User.where("access_token = ? AND updated_at > NOW() AT TIME ZONE 'UTC' - INTERVAL '1 week'", token).first
      return @user if @user

      if (token != 'null')
        oauth2 = Google::Apis::Oauth2V2::Oauth2Service.new
        userinfo = oauth2.tokeninfo(access_token: token)
        @user = User.where(email: userinfo.email).update_all(access_token: token, updated_at: DateTime.now)
      end
    end

    rescue Google::Apis::ClientError
    return
  end

  def authenticate_internal_token
    authenticate_with_http_token do |token, options|
      if (token == Rails.application.secrets.internal_api_key)
        return 'authenticated'
      end
    end
  end
end
