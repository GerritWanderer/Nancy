class ProfilesController < ApplicationController
  def index
    @works = current_user.works
  end

end
