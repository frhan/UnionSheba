ActiveAdmin.register User do

  index do
    selectable_column
    id_column
    column :username
    column :union
    # column :current_sign_in_at
    # column :last_sign_in_at
    # column :sign_in_count
    actions
  end
# Default is :email, but we need to replace this with :username
  filter :username

# This is the form for creating a new user using the Admin
# backend. If you have added additional attributes to the
# User model, you need to include them here.
  form do |f|
    f.inputs "User Details" do
      f.input :username
      f.input :password
      f.input :password_confirmation
      f.input :union_id, :label => 'Union', :as => :select,:collection => Union.all.map{|u| ["#{u.name_in_bng}", u.id]}
      f.input :role_id, :label => 'Role', :as => :select,:collection => Role.all.map{|r| ["#{r.role_name}", r.id]}
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit user: [:username, :password, :password_confirmation,:union_id,:role_id]
    end
  end

end
