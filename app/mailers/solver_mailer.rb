class SolverMailer < ApplicationMailer
	def welcome_email
	    @solver = params[:solver]
	    @password = params[:password]
	    mail(to: @solver.user.email, subject: 'Welcome to CivicSense')
	end
end
