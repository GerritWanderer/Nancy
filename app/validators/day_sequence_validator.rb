class DaySequenceValidator < ActiveModel::Validator
	def validate(record)
		record.errors[:base] = "To must be higher then from" unless to_is_higher_then_from(record)
		record.errors[:base] = "There is already a record" unless no_other_record_exist(record)
	end

	private
	def to_is_higher_then_from(record)
		record.date_to >= record.date_from ? true : false
	end
	def no_other_record_exist(record)
		if record.type_of_sequence == 1
			DaySequence.by_type_within_date(1, record.date_from, record.date_to).empty?
		else
			DaySequence.by_type_within_date(2, record.date_from, record.date_to).where("user_id = ?", record.user_id).empty?
		end
	end
end