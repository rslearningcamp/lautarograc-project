ActiveAdmin.register User do
    menu :priority => 1, :label => "Users"
    permit_params :email, :password, :admin, :active
    scope :all, :default => true
    
    form :html => { :multipart => true } do |f|
        f.inputs "User Details" do
            f.semantic_errors *f.object.errors.keys
            f.input :email
            f.input :password
            f.input :admin
            f.input :active
        end
        f.actions
    end
    show do
        attributes_table do
            row :email
            row :admin
            row :active
        end
    end
end