class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
		begin
			Date.parse(value.to_s)
		rescue ArgumentError
			record.errors[attribute] << (options[:message] || I18n.t('errors.messages.invalid'))
		end
	end
end