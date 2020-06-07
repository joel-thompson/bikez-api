class SuspensionPartSerializer < ActiveModel::Serializer
  attributes :id, :name, :component_type, :high_speed_compression, :low_speed_compression,
             :high_speed_rebound, :low_speed_rebound, :volume, :pressure, :spring_rate
end
