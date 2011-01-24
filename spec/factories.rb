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
	f.department {Faker::Company.name}
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
	f.start { Time.parse("#{Date.today.strftime("%Y-%m-%d")} 09:00") }
	f.end { Time.parse("#{Date.today.strftime("%Y-%m-%d")} 10:00") }
	f.duration {45}
	f.description {Faker::Lorem.paragraph}
	f.user_id {1}
	f.project_id {rand(10)+1}
end

Factory.sequence :startTime do |s| "#{s + 7}" end
Factory.sequence :endTime do |e| "#{e + 8}" end