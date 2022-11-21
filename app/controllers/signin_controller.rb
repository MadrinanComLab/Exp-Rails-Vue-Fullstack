class SigninController < ApplicationController
    # :authorize_access_request IS PART OF jwt_sessions GEM
    before_action :authorize_access_request!, only: [:destroy]

    # create IS FOR LOGIN
    def create
        user = User.find_by(email: params[:email])

        # user.authenticate COMES FROM bcrypt GEM
        if user.authenticate(params[:password])
            # PAYLOAD IS THE DATA THAT WILL BE SENT TO application_controller.rb
            payload = { user_id: user.id } 
            
            # refresh_by_access_allowed: true MEANS THAT IF SOMETHING WENT WRONG, REFRESH THEN MAKE THE USER SIGN IN AGAIN
            session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
            tokens = session.login
            response.set_cookie(
                JWTSessions.access_cookie,
                value: tokens[:access],
                httponly: true,
                secure: Rails.env.production?
            )

            render json: { csrf: tokens[:csrf] }
        else
            # NOTE: not_authorized IS INHERITED FROM application_controller.rb
            not_authorized
        end
    end

    # destroy IS FOR LOGOUT
    def destroy
        session = JWTSessions::Session.new(payload: payload)
        session.flush_by_access_payload
        render json: :ok
    end

    private def not_found
        render json: { error: "Cannot find email/password combination" }, status: not_found
    end
end