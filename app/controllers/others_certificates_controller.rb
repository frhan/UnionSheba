class OthersCertificatesController < InheritedResources::Base
  require 'barby'
  require 'barby/barcode'
  require 'barby/barcode/qr_code'
  require 'barby/outputter/png_outputter'

  include ApplicationHelper, UnionHelper
  before_filter :authenticate_user!, only: [:index, :requests, :no_remarried, :activate_certificate]
  load_and_authorize_resource only: [:index, :requests, :show, :activate_certificate]

  def new
    @others_certificate = OthersCertificate.new
    @others_certificate.build_contact_address
    @others_certificate.build_citizen_basic
    if !user_signed_in?
      @others_certificate.build_image_attachment
    end

    @others_certificate.basic_infos.build(lang: current_lang)
    @others_certificate.addresses.build(address_type: :present, lang: current_lang)
    @others_certificate.addresses.build(address_type: :permanent, lang: current_lang)
    @c_type ||= params[:c_type]

    if should_show_work_info @c_type
      @others_certificate.work_infos.build(lang: current_lang)
    end

    if @c_type == 'freedom_fighter'
      @others_certificate.freedom_fighters.build(lang: current_lang)
    end

    if @c_type == 'relationship'
      @others_certificate.relationships.build
    end

  end

  def create
    @others_certificate = OthersCertificate.new(others_certificate_params)
    @c_type = @others_certificate.certificate_type
    respond_to do |format|
      if @others_certificate.save
        format.html { redirect_to user_signed_in? ? @others_certificate : public_certificate_path(@others_certificate), notice: get_notice }
        format.json { render :no_remarried, status: :created, location: @citizen }
      else
        @others_certificate.build_image_attachment if @others_certificate.image_attachment.blank?
        format.html { render :new,c_ype: @c_type }
        format.json { render json: @others_certificate.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit
    @others_certificate = current_user.others_certificates.find(params[:id])
    @c_type = @others_certificate.certificate_type
  end

  def index
    @others_certificates = current_user.others_certificates.where(status: :active)
                               .order('updated_at desc')
                               .page(params[:page])
                               .per(10)

    @others_certificates = @others_certificates.where("certifcate_no like :search", search: "%#{params[:q]}%") if params[:q].present?

    respond_to do |format|
      format.html
    end
  end


  def show
    @others_certificate = current_user.others_certificates.find(params[:id])
    @barcode = barcode_output(@others_certificate) if params[:format] == 'pdf'

    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => file_name,
               :template => @others_certificate.template,
               :layout => 'pdf.html.erb',
               :disposition => 'attachment',
               page_size: 'A4',
               :show_as_html => params[:debug].present?,
               margin: {top: 8, # default 10 (mm)
                        bottom: 0,
                        left: 5,
                        right: 5},
               dpi: '300'
      end
    end
  end

  def barcode_output(others_certificate)
    barcode_string = others_certificate.barcode
    barcode = Barby::QrCode.new(barcode_string, level: :q, size: 9)

    # PNG OUTPUT
    base64_output = Base64.encode64(barcode.to_png({xdim: 4}))
    "data:image/png;base64,#{base64_output}"
  end


  def show_by_tracking_id
    @others_certificate = OthersCertificate.find_by_tracking_no(params[:id])
  end


  def requests
    @others_certificates = current_user.others_certificates.where(status: :pending)
                               .order('updated_at desc')
                               .page(params[:page])
                               .per(10)

    @others_certificates = @others_certificates.where("tracking_no like :search", search: "%#{params[:q]}%") if params[:q].present?

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

  def activate
    @others_certificate = OthersCertificate.find(params[:id])
    @others_certificate.activate
    redirect_to @others_certificate, notice: 'Certificate was successfully activated.'
  end

  private

  def file_name
    pdf_file_name 'certificate_' << @others_certificate.union_code
  end


  def public_certificate_path(oc)
    return show_by_tracking_certificate_path(oc.tracking_no)
  end

  def get_notice
    user_signed_in? ? 'Certificate was successfully created.' : 'আপনার আবেদনটি সাবমিট করা হয়েছে । ভবিষ্যৎ অনুসন্ধানের জন্য ট্র্যাকিং নম্বরটি সংগ্রহে রাখুন ।'
  end

  def others_certificate_params
    params.require(:others_certificate).permit(:union_id, :certificate_type, :status,
                                               work_infos_attributes: [:id, :for_whom_others, :annual_income, :income_in_bangla,
                                                                       :work_title, :workplace_name, :for_whom_id, :lang, :income_type],
                                               basic_infos_attributes: [:id, :name,:nick_name,:fathers_name, :spouse_name,
                                                                        :mothers_name, :date_of_birth, :lang],
                                               addresses_attributes: [:id, :village, :road, :word_no, :district, :upazila,
                                                                      :post_office, :address_type, :lang],
                                               contact_address_attributes: [:id, :mobile_no, :email],
                                               citizen_basic_attributes: [:id, :nid, :birthid, :dob, :gender,
                                                                          :maritial_status_id, :citizenship_state_id,
                                                                          :religion_id],
                                               image_attachment_attributes: [:id, :photo],
                                               freedom_fighters_attributes:[:id,:red_book_no,:indian_no,:gazette_no,:lang],
                                               relationships_attributes:[:id,:to_whom,:person_title,:relation,:relation_type,:lang])
  end


end
