class CitizensController < InheritedResources::Base
  require 'barby'
  require 'barby/barcode'
  require 'barby/barcode/qr_code'
  require 'barby/outputter/png_outputter'

  include ApplicationHelper, UnionHelper
  before_filter :authenticate_user!, only: [:index, :requests, :show, :activate_citizen]
  load_and_authorize_resource only: [:index, :requests, :show, :activate_citizen]

  def new
    @citizen = Citizen.new
    @citizen.build_contact_address
    @citizen.build_citizen_basic
    if !user_signed_in?
      @citizen.build_image_attachment
    end
    @citizen.basic_infos.build(lang: current_lang)
    @citizen.addresses.build(address_type: :present, lang: current_lang)
    @citizen.addresses.build(address_type: :permanent, lang: current_lang)
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @citizen = Citizen.new(citizen_params)
    respond_to do |format|
      if @citizen.save
        format.html { redirect_to user_signed_in? ? @citizen : public_citizen__path(@citizen), notice: get_notice }
        format.json { render :show, status: :created, location: @citizen }
      else
        @citizen.build_image_attachment if @citizen.image_attachment.blank?
        format.html { render :new }
        format.json { render json: @citizen.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit
    @citizen = current_user.citizens.find(params[:id]);
  end

  def show_by_tracking_id
    @citizen = Citizen.find_by_tracking_id(params[:id])
  end

  def show_by_nid
    @citizen = Citizen.find_by_nid(params[:id])
  end

  def activate_citizen
    @citizen = current_user.citizens.find(params[:id])
    @citizen.activate
    redirect_to @citizen, notice: 'Citizen was successfully activated.'
  end

  def verify_application
    @citizen = Citizen.find_by_tracking_id(params[:q]) if params[:q]
    # where status in
    respond_to do |format|
      format.html
      format.js
    end
  end

  def verify_citizen
    @citizen = Citizen.find_by_citizen_no(params[:q]) if params[:q]
    # where status in
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    @citizens = current_user.citizens.where(status: :active)
                    .order('updated_at desc')
                    .page(params[:page])
                    .per(10)

    @citizens = @citizens.where("citizen_no like :search", search: "%#{params[:q]}%") if params[:q].present?

    respond_to do |format|
      format.html
    end
  end

  def requests
    @citizens = current_user.citizens.where(status: :pending)
                    .order('created_at asc')
                    .page(params[:page])
                    .per(10)
    @citizens = @citizens.where("tracking_id like :search", search: "%#{params[:q]}%") if params[:q].present?

    respond_to do |format|
      format.html
      format.json { render json: @citizens }
    end
  end

  def edit_request
    @citizen = Citizen.find(params[:id]);
  end

  #PUT
  def permit_request
    @citizen = Citizen.find(params[:id]);
    #@citizen.save_citizen_no

    respond_to do |format|
      if @citizen.update(citizen_params)
        format.html { redirect_to requests_citizens_path, notice: 'Citizen was successfully updated' }
        format.json { render :show, status: :ok, location: @citizen }
      else
        format.html { render :edit_request }
        format.json { render json: @citizen.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @citizen = Citizen.find(params[:id])
    @citizen.remove
    respond_to do |format|
      format.html { redirect_to citizens_url, notice: 'Citizen was successfully deleted' }
      format.json { head :no_content }
    end
  end


  def show
    @citizen = current_user.citizens.find(params[:id])
    @barcode = barcode_output(@citizen) if params[:format] == 'pdf'

    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => file_name,
               :template => 'citizens/show.pdf.erb',
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

  def barcode_output(citizen)
    barcode_string = citizen.barcode
    barcode = Barby::QrCode.new(barcode_string, level: :q, size: 9)

    # PNG OUTPUT
    base64_output = Base64.encode64(barcode.to_png({xdim: 4}))
    "data:image/png;base64,#{base64_output}"
  end


  private

  def citizen_params
    params.require(:citizen).permit(:union_id, :status, basic_infos_attributes: [:id, :name, :fathers_name, :mothers_name, :date_of_birth, :lang],
                                    addresses_attributes: [:id, :village, :road, :word_no, :district, :upazila, :post_office, :address_type, :lang],
                                    contact_address_attributes: [:id, :mobile_no, :email],
                                    citizen_basic_attributes: [:id, :nid, :birthid, :dob, :gender, :maritial_status_id,
                                                               :citizenship_state_id, :religion_id],
                                    image_attachment_attributes: [:id, :photo])
  end

  def file_name
    pdf_file_name 'citizen_certificate_' << @citizen.union_code
  end

  def get_notice
    user_signed_in? ? 'Citizen was successfully created.' : 'আপনার আবেদনটি সাবমিট করা হয়েছে । ভবিষ্যৎ অনুসন্ধানের জন্য ট্র্যাকিং নম্বরটি সংগ্রহে রাখুন ।'
  end

  def public_citizen__path(citizen)
    return show_by_tracking_citizens_path(citizen.tracking_id)
  end

end

