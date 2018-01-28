class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    def require_is_admin
        unless current_user.admin?
            redirect_to jobs_path, alert: "尚未擁有權限"     
        end
    end
end
