class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @union = current_user.union

    respond_to do |format|
        format.html
      end

  end

end