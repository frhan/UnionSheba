ActiveAdmin.register TradeOrganization do

  index do
    selectable_column
    id_column
    column :enterprize_name_in_eng
    column :owners_name_eng
    column :license_no
    column :union
    column :status
    column :created_at
    column :updated_at
    actions
  end

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params  :name_in_eng, :name_in_bng,:union_id,:word_no,:status,:license_no
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end