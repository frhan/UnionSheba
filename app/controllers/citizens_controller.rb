class CitizensController < InheritedResources::Base
  before_filter :authenticate_user!

  def index
    if user_signed_in?
      @citizens = Citizen.find_by_union_id(current_user.union.id)
    end
  end

  private

    def citizen_params
      params.require(:citizen).permit(:name_in_eng, :name_in_bng, :fathers_name, :mothers_name, :village, :post, :post, :union_id, :spouse_name)
    end
end

