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