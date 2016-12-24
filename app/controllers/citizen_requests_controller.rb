class CitizenRequestsController < ApplicationController

  def new
    @citizen = Citizen.new
  end

  def create
    @citizen = Citizen.new(citizen_params)

    respond_to do |format|
      if @citizen.save
        format.html { redirect_to root_path, notice: 'Trade License was successfully created.' }
      else
        format.html {render :new }
      end
    end
  end

  private

  def citizen_params
    params.require(:citizen).permit(:name_in_eng, :name_in_bng, :fathers_name,
                                    :mothers_name, :village, :post, :word_no, :union_id,
                                    :spouse_name,:nid,:birthid,:email,:mobile_no)
  end

end
