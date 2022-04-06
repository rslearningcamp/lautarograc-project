# == Schema Information
#
# Table name: topics
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_topics_on_name  (name) UNIQUE
#
class TopicSerializer < ActiveModel::Serializer
  attributes :id, :name, :image

  def image
    img = object.image
    return unless img.attached?

    rails_blob_path(img, disposition: 'attachment',
                         only_path: true)
  end
end
