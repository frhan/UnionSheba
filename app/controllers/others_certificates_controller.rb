class OthersCertificatesController < InheritedResources::Base
  include ApplicationHelper, UnionHelper
  before_filter :authenticate_user! ,only: [:index,:requests,:show,:activate_certificate]
  load_and_authorize_resource only: [:index,:requests,:show,:activate_certificate]

  def requests

  end

  def activate_certificate

  end

  private

  def others_certificate_params
    params.require(:citizen).permit(:union_id, :status, basic_infos_attributes: [:id,:name, :fathers_name,
                                                                                 :mothers_name, :date_of_birth,
                                                                                 :lang],
                                    addresses_attributes: [:id,:village, :road, :word_no, :district, :upazila,
                                                           :post_office, :address_type, :lang],
                                    contact_address_attributes: [:id,:mobile_no, :email],
                                    citizen_basic_attributes:[:id,:nid,:birthid,:dob,:gender,
                                                              :maritial_status_id, :citizenship_state_id,
                                                              :religion_id],
                                    image_attachment_attributes: [:id,:photo])
  end

end
