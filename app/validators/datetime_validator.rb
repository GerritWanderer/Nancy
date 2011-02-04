class DatetimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
		begin
			Date.strptime(value.to_s, "%Y-%m-%d %H:%M")
		rescue ArgumentError
			record.errors[attribute] << (options[:message] || "is not formatted properly")
		end
	end
end