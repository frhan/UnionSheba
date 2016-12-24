class CitizenRequestsController < ApplicationController

  def new
    @citizen = Citizen.new
  end

  def create
    @citizen = Citizen.new(citizen_params)
    @citizen.save_pending_request

    respond_to do |format|
      if @citizen.save
        format.html { redirect_to root_path, notice: 'আপনার আবেদনটি গ্রহণ করা হয়েছে । আবেদনটি গৃহীত হলে আপানকে ইমেইলের মাধ্যমে জানিয়ে দেয়া হবে ।' }
      else
        format.html {render :new }
      end
    end
  end

  def search

  end

  private

  def citizen_params
    params.require(:citizen).permit(:name_in_eng, :name_in_bng, :fathers_name,
                                    :mothers_name, :village, :post, :word_no, :union_id,
                                    :spouse_name,:nid,:birthid,:email,:mobile_no)
  end

end
