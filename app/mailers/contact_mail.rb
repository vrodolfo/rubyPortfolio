class ContactMail < ApplicationMailer

	def contactEmail(user, params, cc)

		@params = params
	 	@user = user
		mail(to: @user.email, cc: cc, subject: params[:subject])
	end
end
