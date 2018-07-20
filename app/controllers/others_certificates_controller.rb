class OthersCertificatesController < InheritedResources::Base
  include ApplicationHelper, UnionHelper
  before_filter :authenticate_user!, only: [:index, :requests, :show, :activate_certificate]
  load_and_authorize_resource only: [:index, :requests, :show, :activate_certificate]

  def new
    @others_certificate = OthersCertificate.new
    @others_certificate.build_contact_address
    @others_certificate.build_citizen_basic
    @others_certificate.build_image_attachment
    @others_certificate.basic_infos.build(lang: current_lang)
    @others_certificate.addresses.build(address_type: :present, lang: current_lang)
    @others_certificate.addresses.build(address_type: :permanent, lang: current_lang)

  end

  def create
    @others_certificate = OthersCertificate.new(others_certificate_params)

    respond_to do |format|
      if @others_certificate.save
        format.html { redirect_to user_signed_in? ?  @others_certificate : show_by_tracking_id(@others_certificate) , notice: get_notice }
        format.json { render :show, status: :created, location: @citizen }
      else
        @others_certificate.build_image_attachment if @others_certificate.image_attachment.blank?
        format.html {render :new }
        format.json { render json: @others_certificate.errors, status: :unprocessable_entity }
      end
    end

  end

  def show_by_tracking_id(cert)
    @others_certificate = cert
  end

  def requests

  end

  def activate_certificate

  end

  private

  def others_certificate_params
    params.require(:others_certificate).permit(:union_id, :status, basic_infos_attributes: [:id, :name, :fathers_name,
                                                                                 :mothers_name, :date_of_birth, :lang],
                                    addresses_attributes: [:id, :village, :road, :word_no, :district, :upazila,
                                                           :post_office, :address_type, :lang],
                                    contact_address_attributes: [:id, :mobile_no, :email],
                                    citizen_basic_attributes: [:id, :nid, :birthid, :dob, :gender,
                                                               :maritial_status_id, :citizenship_state_id,
                                                               :religion_id],
                                    image_attachment_attributes: [:id, :photo])
  end


end
