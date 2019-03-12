class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    google_data = request.env["omniauth.auth"]

    @user = User.find_or_create_from_google_auth(google_data)

    if @user
      sign_in_and_redirect @user 
    else
      flash[:notice] = t(".contact_administrator")
      redirect_to new_user_session_path
    end
  end
end
