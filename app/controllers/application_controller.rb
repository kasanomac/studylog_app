class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_current_user

    def after_sign_in_path_for(resource)
        studytimes_path
    end

    def after_sign_out_path_for(resource)
        new_user_session_path
    end

    def set_current_user
        @current_user = User.find(session[:user_id]) if session[:user_id]
    end
    

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :user])
        devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :avatar])
    end

end
