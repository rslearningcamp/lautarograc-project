ActiveAdmin.register Topic do
  menu priority: 4, label: 'Topics'
  permit_params :name, :image
  scope :all, default: true

  form html: { multipart: true } do |f|
    f.inputs 'Topic' do
      f.input :name
      f.input :image, as: :file
    end
    f.actions
  end
  show do
    attributes_table do
      row :name
      row :image
    end
  end
end
