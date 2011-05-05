class NetzkePreference < ActiveRecord::Base
  serialize :value

  # belongs_to :user
  # belongs_to :role

  # ELEMENTARY_CONVERTION_METHODS= {'Fixnum' => 'to_i', 'String' => 'to_s', 'Float' => 'to_f', 'Symbol' => 'to_sym'}

  # def self.component_name=(value)
  #   @@component_name = value
  # end
  #
  # def self.component_name
  #   @@component_name ||= nil
  # end

  # def normalized_value
  #   klass      = read_attribute(:pref_type)
  #   norm_value = read_attribute(:value)
  #
  #   case klass
  #   when nil             then r = norm_value  # do not cast
  #   when 'Boolean'       then r = norm_value == 'false' ? false : (norm_value == 'true' || norm_value)
  #   when 'NilClass'      then r = nil
  #   when 'Array', 'Hash' then r = ActiveSupport::JSON.decode(norm_value)
  #   else
  #     r = norm_value.send(ELEMENTARY_CONVERTION_METHODS[klass])
  #   end
  #   r
  # end
  #
  # def normalized_value=(new_value)
  #   case new_value.class.name
  #   when "Array" then write_attribute(:value, new_value.to_json)
  #   when "Hash"  then write_attribute(:value, new_value.to_json)
  #   else              write_attribute(:value, new_value.to_s)
  #   end
  #   write_attribute(:pref_type, [TrueClass, FalseClass].include?(new_value.class) ? 'Boolean' : new_value.class.to_s)
  # end
  #
  # def self.[](pref_name)
  #   pref_name  = normalize_preference_name(pref_name)
  #   pref       = self.pref_to_read(pref_name)
  #   pref && pref.normalized_value
  # end
  #
  # def self.[]=(pref_name, new_value)
  #   pref_name  = normalize_preference_name(pref_name)
  #   pref       = self.pref_to_write(pref_name)
  #
  #   # if assigning nil, simply delete the eventually found preference
  #   if new_value.nil?
  #     pref && pref.destroy
  #   else
  #     # pref ||= self.new(conditions(pref_name))
  #     pref.normalized_value = new_value
  #     pref.save!
  #   end
  # end



  # Overwrite pref_to_read, pref_to_write methods, and find_all_for_component if you want a different way of
  # identifying the proper preference based on your own authorization strategy.
  #
  # The default strategy is:
  #   1) if no masq_user or masq_role defined
  #     pref_to_read will search for the preference for user first, then for user's role
  #     pref_to_write will always find or create a preference for the current user (never for its role)
  #   2) if masq_user or masq_role is defined
  #     pref_to_read and pref_to_write will always take the masquerade into account, e.g. reads/writes will go to
  #     the user/role specified
  #
  def self.pref_to_read(name)
    name = name.to_s
    session = Netzke::Core.session
    cond = {:key => name}

    if session[:masq_user]
      # first, get the prefs for this user it they exist
      res = self.where(cond.merge({:user_id => session[:masq_user]})).first

      # if it doesn't exist, get them for the user's role
      user = User.where(session[:masq_user])
      res ||= self.where(cond.merge({:role_id => user.role.id})).first

      # if it doesn't exist either, get them for the World (role_id = 0)
      res ||= self.where(cond.merge({:role_id => 0})).first
    elsif session[:masq_role]
      # first, get the prefs for this role
      res = self.where(cond.merge({:role_id => session[:masq_role]})).first
      # if it doesn't exist, get them for the World (role_id = 0)
      res ||= self.where(cond.merge({:role_id => 0})).first
    elsif session[:netzke_user_id]
      user = User.where(session[:netzke_user_id])
      # first, get the prefs for this user
      res = self.where(cond.merge({:user_id => user.id})).first
      # if it doesn't exist, get them for the user's role
      res ||= self.where(cond.merge({:role_id => user.role.id})).first
      # if it doesn't exist either, get them for the World (role_id = 0)
      res ||= self.where(cond.merge({:role_id => 0})).first
    else
      res = self.where(cond).first
    end

    res
  end

  def self.pref_to_write(name)
    name = name.to_s
    session = Netzke::Core.session
    cond = {:key => name}

    if session[:masq_user]
      cond.merge!({:user_id => session[:masq_user]})
      # first, try to find the preference for masq_user
      res = self.where(cond).first
      # if it doesn't exist, create it
      res ||= self.new(cond)
    elsif session[:masq_role]
      # first, delete all the corresponding preferences for the users that have this role
      Role.where(session[:masq_role]).users.each do |u|
        self.delete_all(cond.merge({:user_id => u.id}))
      end
      cond.merge!({:role_id => session[:masq_role]})
      res = self.where(cond).first
      res ||= self.new(cond)
    elsif session[:masq_world]
      # first, delete all the corresponding preferences for all users and roles
      self.delete_all(cond)
      # then, create the new preference for the World (role_id = 0)
      res = self.new(cond.merge(:role_id => 0))
    elsif session[:netzke_user_id]
      res = self.where(cond.merge({:user_id => session[:netzke_user_id]})).first
      res ||= self.new(cond.merge({:user_id => session[:netzke_user_id]}))
    else
      res = self.where(cond).first
      res ||= self.new(cond)
    end
    res
  end

  # def self.find_all_for_component(name)
  #   session = Netzke::Core.session
  #   cond = {:component_name => name}
  #
  #   if session[:masq_user] || session[:masq_role]
  #     cond.merge!({:user_id => session[:masq_user], :role_id => session[:masq_role]})
  #     res = self.where(cond).all
  #   elsif session[:netzke_user_id]
  #     user = User.where(session[:netzke_user_id])
  #     res = self.where(cond.merge({:user_id => session[:netzke_user_id]})).all
  #     res += self.where(cond.merge({:role_id => user.role.try(:id)})).all
  #   else
  #     res = self.where(cond).all
  #   end
  #
  #   res
  # end

  # def self.delete_all_for_component(name)
  #   self.destroy(find_all_for_component(name))
  # end
  #
  # private
  # def self.normalize_preference_name(name)
  #   name.to_s.gsub(".", "__").gsub("/", "__")
  # end

end
