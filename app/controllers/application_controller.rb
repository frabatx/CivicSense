class ApplicationController < ActionController::Base
  	protect_from_forgery with: :exception

  	protected

   	def check_role
     	if (controller_path == 'solvers' and not (current_user.superuser? or current_user.administration?)) or
     		(controller_path == 'administrations' and not current_user.superuser?)
     		render "shared/not_allowed"
     	end
	end
end
