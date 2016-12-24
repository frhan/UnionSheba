class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @union = current_user.union
  end

end