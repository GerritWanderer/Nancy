class FeesValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    value.split(';').each do |fee|
		  begin
			  Float(fee)
		  rescue ArgumentError
			  record.errors[attribute] << (options[:message] || "#{fee} #{I18n.t('errors.messages.not_a_number')}")
		  end
		end
	end
end
