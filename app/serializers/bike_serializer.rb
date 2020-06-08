class BikeSerializer < ActiveModel::Serializer
  attributes :id, :name , :active_suspension_parts

  def active_suspension_parts
    ActiveModelSerializers::SerializableResource.new(
      @object.active_suspension_parts, 
      each_serializer: SuspensionPartSerializer
    ).serializable_hash
  end
end
