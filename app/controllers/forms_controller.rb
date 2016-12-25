class FormsController < ApplicationController
  before_action :authenticate_user!

  def tax_or_rate_form
    resp_to ('tax_or_rate_form')
  end

  def others_form
    resp_to ('others_form')
  end

  private

  def resp_to (form_name)
    respond_to do |format|
      format.pdf do
        render :pdf => form_name,
               :template => 'forms/'<<form_name<<'.pdf.erb',
               :layout => 'pdf.html.erb',
               :disposition => 'attachment',
               page_size: 'A4',
               :show_as_html => params[:debug].present?,
               margin:  {   top:               20,                     # default 10 (mm)
                            bottom:            10,
                            left:              0,
                            right:             5 },
               dpi:                            '300'
      end
    end
  end
end