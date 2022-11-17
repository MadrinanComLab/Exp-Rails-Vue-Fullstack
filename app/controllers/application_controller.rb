class ApplicationController < ActionController::API
    include JWTSessions::RailsAuthorization # THIS WAS ADDED TO BE ABLE TO USE JWT SESSIONS

    # WE CALL 'not_authorized' METHOD TO REACT ON UNAUTHORIZE ERROR OF JWT SESSION
    rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized 

    private 
        def current_user # THIS IS A PRIVATE METHOD
            # ||= IS CALLED CONDITIONAL ASSIGNMENT OPERATOR
            # YOU CAN READ MORE ABOUT IT IN HERE: https://www.rubyguides.com/2018/07/ruby-operators/#Assignment_Operators
            # THE LINE OF CODE BELOW WILL ASSIGN THE VALUE OF User.find(payload["user_id"]) "IF" @current_user IS EMPTY
            @current_user ||= User.find(payload["user_id"])
        end

        def not_authorized # THIS IS ALSO A PRIVATE METHOD
            render json: { error: "Not authorized" }, status: :unauthorized
        end
end
