class WorkValidator < ActiveModel::Validator
	def validate(record)
		record.errors[:base] = "End time must be higher then Start time" unless end_is_higher_then_start(record)
		record.errors[:base] = "A record already exist within your given time." unless no_other_record_exist(record)
	end

	private
	def end_is_higher_then_start(record)
		record.end_datetime > record.start_datetime ? true : false
	end
	def no_other_record_exist(record)
		Work.where(:user_id => record.user_id).where("(start <= '#{record.start_datetime}' AND end >= '#{record.start_datetime}') OR (start >= '#{record.start_datetime}' AND end >= '#{record.end_datetime}')").empty? ? true : false
	end
end