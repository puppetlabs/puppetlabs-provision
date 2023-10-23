# frozen_string_literal: true

# The function to map the human readable instance type to the Cloud provider instance type
Puppet::Functions.create_function(:'provision::instance_type_mapping') do
  dispatch :instance_type_mapping do
    param 'String', :cloud
    param 'String', :instnace_type
    param 'String', :architecture
    return_type 'String'
  end

  def instance_type_mapping(cloud, instance_type, architecture)
    cloud_sym = cloud.to_sym
    instance_type_sym = instance_type.to_sym
    architecture_sym = architecture.to_sym

    "#{_architecture_mapping(cloud_sym, architecture_sym)}.#{_mapping(cloud_sym, instance_type_sym)}"
  end

  def _mapping(cloud, instance_type)
    map = {
      aws: {
        xlarge: 'xlarge',
        large: 'large',
        standard: 'medium',
        small: 'small',
        micro: 'micro'
      }
    }
    map[cloud][instance_type]
  end

  def _architecture_mapping(cloud, architecture)
    map = {
      aws: {
        arm: 't4g',
        intel: 't3',
        amd: 't3a'
      }
    }
    map[cloud][architecture]
  end
end
