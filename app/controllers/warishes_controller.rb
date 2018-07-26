class WarishesController < InheritedResources::Base
  require 'barby'
  require 'barby/barcode'
  require 'barby/barcode/qr_code'
  require 'barby/outputter/png_outputter'

  include ApplicationHelper, UnionHelper
  before_filter :authenticate_user!, only: [:index, :requests, :show, :activate_warish]
  load_and_authorize_resource only: [:index, :requests, :show, :activate_warish]

  def new
    @warish = Warish.new
    @warish.build_contact_address
    @warish.build_citizen_basic
    @warish.build_image_attachment
    @warish.basic_infos.build(lang: current_lang)
    @warish.addresses.build(address_type: :present, lang: current_lang)
    @warish.addresses.build(address_type: :permanent, lang: current_lang)
    @warish.warish_relations.build
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @warish = Warish.new(warish_params)

    respond_to do |format|
      if @warish.save
        format.html { redirect_to user_signed_in? ? @warish : public_warish_path(@warish), notice: get_notice }
        format.json { render :show, status: :created, location: @warish }
      else
        @warish.build_image_attachment if @warish.image_attachment.blank?
        format.html { render :new }
        format.json { render json: @warish.errors, status: :unprocessable_entity }
      end
    end

  end

  def show_by_tracking_id
    @warish = Warish.find_by_tracking_id(params[:id])
  end

  def activate_warish
    @warish = Warish.find(params[:id])
    @warish.activate
    redirect_to @warish, notice: 'Warish was successfully activated.'
  end

  def verify_application
    @warish = Warish.find_by_tracking_id(params[:q]) if params[:q]
    # where status in
    respond_to do |format|
      format.html
      format.js
    end
  end

  def verify_warish
    @warish = Warish.find_by_warish_no(params[:q]) if params[:q]
    # where status in
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    @warishes = current_user.warishes.where(status: :active)
                    .order('updated_at desc')
                    .page(params[:page])
                    .per(10)

    @warishes = @warishes.where("warish_no like :search", search: "%#{params[:q]}%") if params[:q].present?

    respond_to do |format|
      format.html
    end
  end

  def requests
    @warishes = current_user.warishes.where(status: :pending)
                    .order('created_at asc')
                    .page(params[:page])
                    .per(10)
    @warishes = @warishes.where("tracking_id like :search", search: "%#{params[:q]}%") if params[:q].present?

    respond_to do |format|
      format.html
      format.json { render json: @citizens }
    end
  end

  def edit_request
    @warish = Warish.find(params[:id]);
  end

  #PUT
  def permit_request
    @warish = Warish.find(params[:id]);
    #@citizen.save_citizen_no

    respond_to do |format|
      if @warish.update(citizen_params)
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
    @warish = Warish.find(params[:id])
    @warish.update_attributes(status: :deleted)
    respond_to do |format|
      format.html { redirect_to citizens_url, notice: 'Citizen was successfully deleted' }
      format.json { head :no_content }
    end
  end

  def show
    @warish = Warish.find(params[:id])
    @barcode = barcode_output(@warish) if params[:format] == 'pdf'

    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => file_name,
               :template => 'warishes/show.pdf.erb',
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

  def search

  end

  def barcode_output(warish)
    barcode_string = warish.barcode
    barcode = Barby::QrCode.new(barcode_string, level: :q, size: 9)

    # PNG OUTPUT
    base64_output = Base64.encode64(barcode.to_png({xdim: 4}))
    "data:image/png;base64,#{base64_output}"
  end


  private

  def warish_params
    params.require(:warish).permit(:union_id, :status, warish_relations_attributes: [:name, :age, :comment, :relation],
                                   basic_infos_attributes: [:id, :name, :fathers_name, :mothers_name, :date_of_birth,
                                                            :father_alive, :mother_alive, :lang],
                                   addresses_attributes: [:id, :village, :road, :word_no, :district, :upazila,
                                                          :post_office, :address_type, :lang],
                                   contact_address_attributes: [:id, :mobile_no, :email],
                                   citizen_basic_attributes: [:id, :nid, :birthid, :dob, :gender, :maritial_status_id,
                                                              :citizenship_state_id, :religion_id])
  end

  def file_name
    pdf_file_name 'warish_certificate_' << @warish.union_code
  end

  def get_notice
    user_signed_in? ? 'Warsih is successfully created.' : 'আপনার আবেদনটি সাবমিট করা হয়েছে । ভবিষ্যৎ অনুসন্ধানের জন্য ট্র্যাকিং নম্বরটি সংগ্রহে রাখুন ।'
  end

  def public_warish_path(warish)
    return show_by_tracking_warishes_path(warish.tracking_id)
  end

end

