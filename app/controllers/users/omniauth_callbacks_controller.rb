# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    Rails.logger.info "Google OAuth callback received"
    Rails.logger.info "Auth data: #{request.env['omniauth.auth'].inspect}"
    
    @user = User.from_omniauth(request.env["omniauth.auth"])
    Rails.logger.info "User: #{@user.inspect}"
    Rails.logger.info "User persisted?: #{@user.persisted?}"
    Rails.logger.info "User errors: #{@user.errors.full_messages}" if @user.errors.any?

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      flash[:notice] = "Signed in with Google!" if is_navigational_format?
    else
      session["devise.google_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url, alert: "Google login failed."
    end
  end

  def failure
    redirect_to root_path, alert: "Could not authenticate you from Google."
  end
end
