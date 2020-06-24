class BikeSerializer < ActiveModel::Serializer
  attributes :id, :name , :active_suspension_part_ids

  def active_suspension_part_ids
    @object.active_suspension_parts.map(&:id)
  end
end
