class CitizenRequestsController < ApplicationController
    include ApplicationHelper
  def new
    @citizen = Citizen.new
  end

  def create
    @citizen = Citizen.new(citizen_params)
    @citizen.save_pending_request

    respond_to do |format|
      if @citizen.save
        format.html { redirect_to citizen_request_info_path(@citizen), notice: 'আপনার আবেদনটি গ্রহণ করা হয়েছে । আবেদনটি গৃহীত হলে আপানকে ইমেইলের মাধ্যমে জানিয়ে দেয়া হবে ।' }
      else
        format.html {render :new }
      end
    end
  end

  def search
    #exact matching
    @citizens = Citizen.where("nid = :search or birthid = :search",search: "#{params[:sSearch]}");

    # where status in
    respond_to do |format|
        format.html
        format.js
    end
  end

  def show_by_birthid
      @citizen = Citizen.find_by_birthid(params[:id])
      do_respond(@citizen)
  end

  def show_by_nid
    @citizen = Citizen.find_by_nid(params[:id])
    do_respond(@citizen)
  end


  private

  def citizen_params
    params.require(:citizen).permit(:name_in_eng, :name_in_bng, :fathers_name,
                                    :mothers_name, :village, :post, :word_no, :union_id,
                                    :spouse_name,:nid,:birthid,:email,:mobile_no,:gender)
  end

  def do_respond(citizen)
    respond_to do |format|
      format.html
      format.pdf do
        if citizen.active?
          render :pdf => citizen_file_name(citizen),
                 :template => 'citizens/show.pdf.erb',
                 :layout => 'pdf.html.erb',
                 :disposition => 'attachment',
                 page_size: 'A4',
                 :show_as_html => params[:debug].present?,
                 margin:  {   top:               0,                     # default 10 (mm)
                              bottom:            0,
                              left:              0,
                              right:             0 },
                 dpi:                            '300'
        end
      end
    end

  end

  def citizen_request_info_path(citizen)
    return show_by_nid_citizen_request_path(citizen.nid) if citizen.nid.present?
    return show_by_birthid_citizen_request_path(citizen.birthid) if citizen.birthid.present?
  end


end
