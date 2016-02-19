class SampleMail < MailForm::Base
	attributes :name, :email

	def headers
		{to: "recipient@ex.com", from: self.email}
	end
end