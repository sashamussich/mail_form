module MailForm
	class Base 
		include ActiveModel::AttributeMethods
		include ActiveModel::Conversion 
		extend ActiveModel::Naming
		include ActiveModel::Validations


		attribute_method_prefix 'clear_'
		attribute_method_suffix '?'

		def self.attributes *names
			attr_accessor *names
			define_attribute_methods names
		end

		def deliver
			if valid?
				MailForm::Notifier.contact(self).deliver
			else
				false
			end
		end

		def persisted?
			false
		end

		protected

		def clear_attribute attribute
			send("#{attribute}=", nil)
		end

		def attribute? attribute
			send(attribute).present?
		end
	end
end