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

  def get
    user = User.find(params[:id])
    render :json => user.full(params[:time_span])
  end

  private

  def user_params
    params.require(:user).permit(:google_id, :name, :email, :given_name, :last_name, :pro_pic_url, :access_token)
  end
end
