require 'faker'

user = User.create!(:firstname => Faker::Name.first_name,
             :lastname => Faker::Name.last_name,
             :email => "admin@example.org",
             :password => "yourpassword")
user.sign_in_count = 1
user.confirmed_at = "2011-01-18 12:10:00"
user.save

6.times do
  new_customer = Customer.create!(:name => Faker::Company.name,
                                  :shortname => Faker::Company.name,
                                  :website => Faker::Internet.domain_name)
  3.times do
    new_location = Location.create!(:name => Faker::Company.name,
                                    :street => Faker::Address.street_address,
                                    :zip => Faker::Address.zip_code,
                                    :city => Faker::Address.city,
                                    :fon => Faker::PhoneNumber.phone_number,
                                    :fax => Faker::PhoneNumber.phone_number,
                                    :customer_id => new_customer.id)
    3.times do
      Contact.create!(:salutation => Faker::Name.prefix,
                      :title => Faker::Name.suffix,
                      :firstname => Faker::Name.first_name,
                      :lastname => Faker::Name.last_name,
                      :department => Faker::Lorem.words,
                      :email => Faker::Internet.email,
                      :fon => Faker::PhoneNumber.phone_number,
                      :mobile => Faker::PhoneNumber.phone_number,
                      :fax => Faker::PhoneNumber.phone_number,
                      :location_id => new_location.id )
    end
  end
end

12.times do
  contact = Contact.all.shuffle.first
  customer = contact.location.customer
  Project.create!(:title => Faker::Lorem.sentence,
                  :description => Faker::Lorem.paragraph,
                  :discount => rand(20),
                  :budget => rand(500),
                  :type => rand(4),
                  :closed => rand(2), 
                  :customer_id => customer.id,
                  :contact_id => contact.id)
end

projects = Project.find_all_by_closed(false)
User.all.each do |user|
	workday = Date.today.-(Date.today.cwday - 1)
	5.times do
	  timeStart = Time.parse("#{workday.strftime("%Y-%m-%d")} 08:00")
	  timeEnd = Time.parse("#{workday.strftime("%Y-%m-%d")} 08:45")
	  8.times do
	    timeStart = timeEnd
	    duration = (rand(8)+1)*15
	    timeEnd = timeStart + (duration * 60)
	    Work.create!(:start => timeStart.strftime('%Y-%m-%d %H:%M'),
	                    :end => timeEnd.strftime('%Y-%m-%d %H:%M'),
	                    :duration => duration,
	                    :description => Faker::Lorem.sentence,
	                    :project_id => projects.shuffle.first.id,
                      :user_id => user.id)
	  end
	  workday = workday.+(1)
	end
end