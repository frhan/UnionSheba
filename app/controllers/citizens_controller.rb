class CitizensController < InheritedResources::Base
  include ApplicationHelper
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html
      format.json { render json: CitizensDatatable.new(view_context,current_user) }
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @citizen = Citizen.find(params[:id])
    @citizen.update_attributes(status: :inactive)
    respond_to do |format|
      format.html { redirect_to citizens_url, notice: 'Citizen was successfully deleted' }
      format.json { head :no_content }
    end
  end


  def show
    @citizen = Citizen.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        #TODO:update issue date
        render :pdf => file_name,
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

  private

  def citizen_params
    params.require(:citizen).permit(:name_in_eng, :name_in_bng, :fathers_name,
                                    :mothers_name, :village, :post, :word_no, :union_id,
                                    :spouse_name,:nid,:birthid)
  end

  def file_name
    pdf_file_name 'citizen_certificate_'
  end
end

