class CitizensController < InheritedResources::Base
  before_filter :authenticate_user!

  def index
    if user_signed_in?
      @citizens = Citizen.where(:union_id => current_user.union.id)
    end
  end

  def show
    @citizen = Citizen.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => file_name,
               :template => 'citizens/show.pdf.erb',
               :layout => 'pdf.html.erb',
               :disposition => 'attachment',
               :show_as_html => params[:debug].present?
      end
    end
  end

  private

  def citizen_params
    params.require(:citizen).permit(:name_in_eng, :name_in_bng, :fathers_name,
                                    :mothers_name, :village, :post, :word_no, :union_id, :spouse_name,:nid,:birthid)
  end

  def file_name
    'file_name'
  end
end

