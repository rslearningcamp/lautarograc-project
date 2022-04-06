class TopicSerializer < ActiveModel::Serializer
  attributes :id, :name, :image

  def image
    img = object.image
    return unless img.attached?

    rails_blob_path(img, disposition: 'attachment',
                         only_path: true)
  end
end
