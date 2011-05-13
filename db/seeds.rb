require 'faker'
I18n.default_locale = :en
user = User.create!(:firstname => ENV['ADMIN_FIRSTNAME'],
             :lastname => ENV['ADMIN_LASTNAME'],
             :email => ENV['ADMIN_EMAIL'],,
             :password => ENV['ADMIN_PASWORD'],)
user.sign_in_count = 1
user.confirmed_at = "2011-01-18 12:10:00"
user.role = "admin"
user.save

Configuration.create!(:key => 'work_fees',
  :value => '70.00;50.00;0.00',
  :label => "Please enter your available fees, seperated with ';'")
Configuration.create!(:key => 'currency',
  :value => '$',
  :label => "Select your currency.")
Configuration.create!(:key => 'tax',
  :value => '19',
  :label => "Select your tax.")
Configuration.create!(:key => 'sender',
  :value => 'Your Company Name - Your Street Address - ZIP and City',
  :label => "Enter your sender details for your report output")

i = 2
3.times do
	user = User.create!(:firstname => Faker::Name.first_name,
	             :lastname => Faker::Name.last_name,
	             :email => "user#{i}@example.org",
	             :password => "development")
	user.sign_in_count = 1
	user.confirmed_at = "2011-01-18 12:10:00"
	user.save
	i += 1
end

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
                      :department => Faker::Lorem.words.first,
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
  project = Project.create!(:title => Faker::Lorem.sentence,
                  :description => Faker::Lorem.paragraph,
                  :discount => rand(20),
                  :budget => rand(500),
                  :type => rand(4),
                  :closed => rand(2), 
                  :customer_id => customer.id,
                  :contact_id => contact.id)
                  
  users = User.all.shuffle
  i = 0
  (rand(2)+1).times do
    ProjectsUsers.create!(:user_id => users[i].id, :project_id => project.id)
    i += 1
  end
  
  (rand(3)).times do
    user = User.all.shuffle.first
    Expense.create!(:user_id => user.id,
                    :project_id => project.id,
                    :description => Faker::Lorem.sentence,
                    :amount => (rand(199) + (rand(99).to_f / 100)).to_f)
  end
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
	    Work.create!(:started_at => timeStart.strftime('%Y-%m-%d %H:%M'),
	                    :ended_at => timeEnd.strftime('%Y-%m-%d %H:%M'),
	                    :duration => duration,
	                    :description => Faker::Lorem.sentence,
	                    :fee => [70.00,50.00,0.00][1],
	                    :project_id => projects.shuffle.first.id,
                      :user_id => user.id)
	  end
	  workday = workday.+(1)
	end
end