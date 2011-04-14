class WorkValidator < ActiveModel::Validator
	def validate(record)
		record.errors[:base] =I18n.t(:works_error_higher, :field1 => Work.human_attribute_name('ended_at'), :field2 => Work.human_attribute_name('started_at')) unless end_is_higher_then_start(record)
		record.errors[:base] = I18n.t(:works_error_exist) unless no_other_record_exist(record)
	end

	private
	def end_is_higher_then_start(record)
		record.end_datetime > record.start_datetime ? true : false
	end
	def no_other_record_exist(record)
		Work.where(:user_id => record.user_id).where("(started_at > '#{record.start_datetime}:59' AND started_at < '#{record.end_datetime}:00') OR (started_at < '#{record.start_datetime}:00' AND ended_at > '#{record.end_datetime}:59') OR (ended_at > '#{record.start_datetime}:59' AND ended_at < '#{record.end_datetime}:59')").empty? ? true : false
	end
end

