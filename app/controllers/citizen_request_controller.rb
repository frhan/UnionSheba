class CitizenRequestController < ApplicationController

  def new
    @citizen = Citizen.new
  end

  def create
    @citizen = Citizen.new(citizen_params)
  end

  private

  def citizen_params
    params.require(:citizen).permit(:name_in_eng, :name_in_bng, :fathers_name,
                                    :mothers_name, :village, :post, :word_no, :union_id,
                                    :spouse_name,:nid,:birthid,:email,:mobile_no)
  end

end
