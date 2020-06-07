class BikeSerializer < ActiveModel::Serializer
  attributes :id, :name # , :active_suspension_parts

  # def active_suspension_parts
  #   @object.active_suspension_parts
  # end
end
