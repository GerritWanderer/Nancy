require 'faker'

3.times do
  new_customer = Customer.create!(:name => Faker::Company.name,
                                  :shortname => Faker::Company.name,
                                  :website => Faker::Internet.domain_name)
  
  4.times do
    new_location = Location.create!(:name => Faker::Company.name,
                                    :street => Faker::Address.street_address,
                                    :zip => Faker::Address.zip_code,
                                    :city => Faker::Address.city,
                                    :fon => Faker::PhoneNumber.phone_number,
                                    :fax => Faker::PhoneNumber.phone_number,
                                    :customer_id => new_customer.id)
    
    2.times do
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

10.times do
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
