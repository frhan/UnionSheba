ActiveAdmin.register Union do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :name_in_eng, :name_in_bng, :desc,:upazila_id,:union_no,:post,:logo,:watermark_logo,:union_code,:chairman_name,:show_signature
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end
