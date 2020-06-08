class BikeSerializer < ActiveModel::Serializer
  attributes :id, :name , :active_suspension_parts

  # this needs to change. maybe just return a list of ids
  # all the work to be done is around settings for suspension parts
  # it will be annoying have them embedded here
  # i'll want to be interacting with their controller directly
  # i need to know their relation to the bike though so i can properly select them
  def active_suspension_parts
    ActiveModelSerializers::SerializableResource.new(
      @object.active_suspension_parts, 
      each_serializer: SuspensionPartSerializer
    ).serializable_hash
  end
end
