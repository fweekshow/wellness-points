class SessionsController < ApplicationController
  def omniauth
    auth = request.env['omniauth.auth']
    user = User.from_omniauth(auth)
    
    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      flash[:notice] = "Signed in with Google!"
    else
      session['devise.google_data'] = auth.except('extra')
      redirect_to new_user_registration_url, alert: "Google login failed."
    end
  end
end 