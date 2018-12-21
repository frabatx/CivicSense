class ScreamerMailer < ApplicationMailer
	def created
	    @scream = params[:scream]
	    mail(to: @scream.screamer_email, subject: 'Scream sent!')
	end

	def updated
	    @scream = params[:scream]
	    mail(to: @scream.screamer_email, subject: 'Scream updated!')
	end
end
