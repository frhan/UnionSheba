class FormsController < ApplicationController
  before_action :authenticate_user!

  def tax_or_rate_form
    resp_to ('forms/tax_or_rate_form.pdf.erb')
  end

  def others_form
    resp_to ('forms/others_form.pdf.erb')
  end

  private

  def resp_to (form_name)
    respond_to do |format|
      format.pdf do
        render :pdf => 'form',
               :template => form_name,
               :layout => 'pdf.html.erb',
               :disposition => 'attachment',
               page_size: 'A4',
               :show_as_html => params[:debug].present?,
               margin:  {   top:               10,                     # default 10 (mm)
                            bottom:            10,
                            left:              10,
                            right:             10 },
               dpi:                            '300'
      end
    end
  end
end