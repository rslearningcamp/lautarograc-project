ActiveAdmin.register Target do
  menu priority: 1, label: 'Targets'
  permit_params :title, :radius, :latitude, :longitude, :topic_id, :user_id, :active

  scope :all, default: true

  form html: { multipart: true } do |f|
    f.inputs 'Target Details' do
      f.input :title
      f.input :radius
      f.input :latitude
      f.input :longitude
      f.input :topic_id
      f.input :user_id
      f.input :active
    end
    f.actions
  end
end
