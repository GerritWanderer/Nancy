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
