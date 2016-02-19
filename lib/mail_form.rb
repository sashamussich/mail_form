module MailForm
	autoload :Base, "mail_form/base"
	autoload :Notifier, "mail_form/notifier"

	class_attribute :attribute_names
	self.attribute_names = []

	def self.attributes(*names)
		attr_accessor *names
		define_attribute_methods names

		self.attribute_names += names
	end
end
