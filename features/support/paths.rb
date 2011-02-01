module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
      when /the login page/
        new_user_session_path
      when /the logout page/
        destroy_user_session_path
      when /the registration page/
        new_user_registration_path
      when /the start page/
        root_path

			when /the settings page/
        settings_user_admin_index_path
        
      when /edit page for that project/
        raise 'no project' unless @project
        edit_project_path(@project)
      when /page for that project/
        raise 'no project' unless @project
        project_path(@project)
      when /edit page for the (\d+)(?:st|nd|rd|th) project/
        raise 'no projects' unless @projects
        nth_project = @projects[$1.to_i - 1]
        edit_project_path(nth_project)
      when /page for the (\d+)(?:st|nd|rd|th) project/
        raise 'no projects' unless @projects
        nth_project = @projects[$1.to_i - 1]
        project_path(nth_project)

      when /edit page for that contact/
        raise 'no contact' unless @contact
        edit_contact_path(@contact)
      when /page for that contact/
        raise 'no contact' unless @contact
        contact_path(@contact)
      when /edit page for the (\d+)(?:st|nd|rd|th) contact/
        raise 'no contacts' unless @contacts
        nth_contact = @contacts[$1.to_i - 1]
        edit_contact_path(nth_contact)
      when /page for the (\d+)(?:st|nd|rd|th) contact/
        raise 'no contacts' unless @contacts
        nth_contact = @contacts[$1.to_i - 1]
        contact_path(nth_contact)

      when /edit page for that location/
        raise 'no location' unless @location
        edit_location_path(@location)
      when /page for that location/
        raise 'no location' unless @location
        location_path(@location)
      when /edit page for the (\d+)(?:st|nd|rd|th) location/
        raise 'no locations' unless @locations
        nth_location = @locations[$1.to_i - 1]
        edit_location_path(nth_location)
      when /page for the (\d+)(?:st|nd|rd|th) location/
        raise 'no locations' unless @locations
        nth_location = @locations[$1.to_i - 1]
        location_path(nth_location)

      when /edit page for that customer/
        raise 'no customer' unless @customer
        edit_customer_path(@customer)
      when /page for that customer/
        raise 'no customer' unless @customer
        customer_path(@customer)
      when /edit page for the (\d+)(?:st|nd|rd|th) customer/
        raise 'no customers' unless @customers
        nth_customer = @customers[$1.to_i - 1]
        edit_customer_path(nth_customer)
      when /page for the (\d+)(?:st|nd|rd|th) customer/
        raise 'no customers' unless @customers
        nth_customer = @customers[$1.to_i - 1]
        customer_path(nth_customer)


    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end
World(NavigationHelpers)