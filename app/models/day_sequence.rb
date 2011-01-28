class DaySequence < ActiveRecord::Base
  belongs_to :user

	def date_from
		Date.today.strftime("%Y-%m-%d")
	end
	def date_to
		Date.today.strftime("%Y-%m-%d")
	end
end
