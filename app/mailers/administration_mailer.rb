class AdministrationMailer < ApplicationMailer
	def welcome_email
	    @administration = params[:administration]
	    @password = params[:password]
	    mail(to: @administration.user.email, subject: 'Welcome to CivicSense')
	end
end
