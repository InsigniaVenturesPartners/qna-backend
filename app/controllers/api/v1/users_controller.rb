class Api::V1::UsersController < Api::V1::BaseController
  def register_user
    if !user_params[:access_token] || !user_params[:email] || !user_params[:insignia_uid]
      return render_error(422, {error: "Access token, Insignia UID, and email are required"})
    end
    user = User.where(email: user_params[:email]).first_or_create
    updateParams = user_params
    if (user_params[:sign_in_count] && user[:sign_in_count])
      updateParams = updateParams.merge(
        sign_in_count: user[:sign_in_count] + 1
      )
    end
    user.update_attributes!(updateParams)
    return render :json => user
  end

  private

  def user_params
    params.permit(:name, :email, :access_token, :pro_pic_url, :google_id,
      :insignia_uid, :current_sign_in_at, :last_sign_in_at,
      :current_sign_in_ip, :last_sign_in_ip, :sign_in_count
    )
  end
end
