require 'Faker'

Factory.define :customer do |f|
	f.name {Faker::Company.name}
	f.shortname {Faker::Company.name}
	f.website {Faker::Internet.domain_name}
	f.locations { [Factory.create(:location), Factory.create(:location), Factory.create(:location)] } 
end

Factory.define :location do |f|
	f.name {Faker::Company.name}
	f.street {Faker::Address.street_address}
	f.zip {Faker::Address.zip_code}
	f.city {Faker::Address.city}
	f.fon {Faker::PhoneNumber.phone_number}
	f.fax {Faker::PhoneNumber.phone_number}
	f.contacts { [Factory.create(:contact), Factory.create(:contact), Factory.create(:contact)] } 
end

Factory.define :contact do |f|
	f.salutation {Faker::Name.prefix}
	f.title {Faker::Name.suffix}
	f.firstname {Faker::Name.first_name}
	f.lastname {Faker::Name.last_name}
	f.department {Faker::Lorem.words.first}
	f.email {Faker::Internet.email}
	f.fon {Faker::PhoneNumber.phone_number}
	f.mobile {Faker::PhoneNumber.phone_number}
	f.fax {Faker::PhoneNumber.phone_number}
end

Factory.define :project do |f|
	f.title {Faker::Company.name}
	f.description {Faker::Lorem.paragraph}
	f.discount {rand(20)}
	f.budget {rand(500)}
	f.closed {rand(2)}
	f.customer_id {2}
	f.contact_id {rand(9)+9}
end

Factory.define :work do |f|
	f.sequence(:started_at) { |n| Time.parse("#{Date.today.strftime("%Y-%m-%d")} #{n+2}:00") }
	f.duration {15}
	f.fee {50.0}
	f.description {Faker::Lorem.paragraph}
	f.user_id {1}
	f.project_id {rand(10)+1}
	f.after_build do |work|
		work.ended_at = work.started_at.+(work.duration*60)
	end
end

	
Factory.define :user do |f|
	f.firstname {Faker::Name.first_name}
	f.lastname {Faker::Name.last_name}
	f.email {Faker::Internet.email}
	f.password {"development"}
	f.sign_in_count {1}
	f.confirmed_at {Date.today.strftime("%Y-%m-%d 09:00")}
	f.days { [Factory.create(:day), Factory.create(:day), Factory.create(:day)] } 
end

Factory.define :day do |f|
	f.date_from { Date.parse("#{Date.today.year}-#{rand(12)+1}-#{rand(28)+1}").strftime("%Y-%m-%d") }
	f.type_of_day {rand(2)+2}
	f.after_build do |day|
		day.date_to = day.date_from.+rand(10)
	end
end

Factory.define :holiday, :class => Day do |f|
	f.date_from { Date.parse("#{Date.today.year}-#{rand(12)+1}-#{rand(28)+1}").strftime("%Y-%m-%d") }
	f.type_of_day 1
	f.after_build do |holiday|
		holiday.date_to = holiday.date_from.+rand(3)
	end
end