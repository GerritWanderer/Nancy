module ApplicationHelper
  def display_navigation(controller)
    navigation = "<ul>\n<li class='#{'active' if controller == 'works'}'>"
    navigation += link_to t(:top_works), works_path
    navigation += "</li>\n<li class='#{'active' if controller == 'customers' or controller == 'locations' or controller == 'contacts'}'>"
    navigation += link_to t(:top_customers), customers_path
    navigation += "</li>\n<li class='#{'active' if controller == 'projects'}'>"
    navigation += link_to t(:top_projects), projects_path
    navigation += "</li>\n<li class='small #{'active' if controller == 'registrations'}'>"
    navigation += link_to t(:top_profile), edit_user_registration_path
    if current_user.role == "admin"
      navigation += "</li>\n<li class='small #{'active' if controller == 'days' or controller == 'user'}'>"
      navigation += link_to t(:top_settings), settings_user_admin_index_path
    end
    navigation += "</li>\n<li class='small'>"
    navigation += link_to t(:top_logout), destroy_user_session_path 
    navigation += "</li>\n<li class='language'><div id='dropdownButtonContainer'></div></li>"
    navigation += "</li>\n</ul>\n"
    raw(navigation)
  end
end