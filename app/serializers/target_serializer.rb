class TargetSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :radius, :title
  belongs_to :topic
end
