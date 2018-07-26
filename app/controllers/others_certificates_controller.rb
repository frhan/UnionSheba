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
        format.html { redirect_to user_signed_in? ? @others_certificate : public_certificate_path(@others_certificate), notice: get_notice }
        format.json { render :show, status: :created, location: @citizen }
      else
        @others_certificate.build_image_attachment if @others_certificate.image_attachment.blank?
        format.html { render :new }
        format.json { render json: @others_certificate.errors, status: :unprocessable_entity }
      end
    end

  end

  def index
    @others_certificates = current_user.others_certificates.where(status: :active)
                               .order('updated_at desc')
                               .page(params[:page])
                               .per(10)

    @others_certificates = @others_certificates.where("certificate_no like :search", search: "%#{params[:q]}%") if params[:q].present?

    respond_to do |format|
      format.html
    end
  end

  def show_by_tracking_id
    @others_certificate = OthersCertificate.find_by_tracking_no(params[:id])
  end


  def requests
    @others_certificates = current_user.others_certificates.where(status: :pending)
                               .order('updated_at desc')
                               .page(params[:page])
                               .per(10)

    @others_certificates = @others_certificates.where("certificate_no like :search", search: "%#{params[:q]}%") if params[:q].present?

    respond_to do |format|
      format.html
    end
  end


  def verify_application
    @others_certificate = OthersCertificate.find_by_tracking_no(params[:q]) if params[:q]
    # where status in
    respond_to do |format|
      format.html
      format.js
    end
  end

  def verify_certificate
    @others_certificate = OthersCertificate.find_by_certifcate_no(params[:q]) if params[:q]
    # where status in
    respond_to do |format|
      format.html
      format.js
    end
  end

  def activate_certificate

  end

  private

  def public_certificate_path(oc)
    return show_by_tracking_certificate_path(oc.tracking_no)
  end

  def get_notice
    user_signed_in? ? 'Certificate was successfully created.' : 'আপনার আবেদনটি সাবমিট করা হয়েছে । ভবিষ্যৎ অনুসন্ধানের জন্য ট্র্যাকিং নম্বরটি সংগ্রহে রাখুন ।'
  end

  def others_certificate_params
    params.require(:others_certificate).permit(:union_id, :certificate_type, :status,
                                               basic_infos_attributes: [:id, :name, :fathers_name,
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
