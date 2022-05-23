ActiveAdmin.register User do
  menu priority: 1, label: 'Users'
  permit_params :email, :password, :admin, :active
  scope :all, default: true

  form html: { multipart: true } do |f|
    f.inputs 'User Details' do
      f.semantic_errors(*f.object.errors.keys)
      f.input :email
      f.input :name
      f.input :nickname
      f.input :vip
      f.input :image, as: :file
    end
    f.actions
  end
  show do
    attributes_table do
      row :email
      row :name
      row :image
      row :vip
    end
  end
end
