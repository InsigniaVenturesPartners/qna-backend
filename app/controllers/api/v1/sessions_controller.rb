require 'google/api_client/client_secrets'

class Api::V1::SessionsController < Api::V1::BaseController

  def create
    unless User.is_whitelisted(user_params[:email])
      return render_error(403, {error: "For access, email hello@insignia.vc or WhatsApp +1978-743-9543"})
    end

    if user_params[:google_id]
      user = User.find_or_create_from_google_auth(user_params)

      return render :json => user.to_json(:methods => :has_offline_access)
    else
      render_error(422, {error: "Please pass user's Google ID"})
    end
  end

  def google_auth
    jsonfile = Rails.env.production??
    'client_secret_258885665996-8jqtfretgtag60q93047fq8jdqlmitmt.apps.googleusercontent.com.json' :
    'client_secret_1088352541792-g3gme4e9ol8akmus0qj5do2nb9fql373.apps.googleusercontent.com.json'

    auth_client =
        Google::APIClient::ClientSecrets.load(
            File.join(
                Rails.root,
                'config',
                jsonfile
            )
        ).to_authorization

    auth_client.update!(
        :redirect_uri => Rails.env.production?? 'http://qna.insignia.vc' : 'http://localhost:3000'
    );

    auth_client.code = params[:code]
    auth_client.fetch_access_token!

    oauth = Google::Apis::Oauth2V2::Oauth2Service.new
    oauth.authorization = auth_client

    user = User.find_by_google_id(oauth.get_userinfo().id)
    partnerAuth = PartnerAuth.where(provider: "google", user_id: user.id).first

    if (partnerAuth)
      partnerAuth.update(auth_json: auth_client.to_json)
    else
      partnerAuth = PartnerAuth.create!(
          user_id: user.id,
          provider: "google",
          auth_json: auth_client.to_json
      )
    end

    render :json => user.to_json(:methods => :has_offline_access)
  end

  def get
    user = User.find(params[:id])
    render :json => user.full(params[:time_span])
  end

  private

  def user_params
    params.require(:user).permit(:google_id, :name, :email, :given_name, :last_name, :pro_pic_url, :access_token)
  end
end
