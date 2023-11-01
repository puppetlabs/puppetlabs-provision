# frozen_string_literal' => true

#
# @summary The function to map the human readable instance type to the Cloud provider instance type
#
# @param cloud The cloud provider
# @param instance_type The human readable instance type
# @param architecture The architecture of the instance
#
# @return [String] A instance type mapped to the respective cloud provider
#
function provision::map_instance_type(
  Provision::CloudProvider $cloud,
  String[1] $instance_type,
  Provision::Architecture $architecture
) >> String {
  $type_mapping = {
    'aws' => {
      'xlarge' => 'xlarge',
      'large' => 'large',
      'standard' => 'medium',
      'small' => 'small',
      'micro' => 'micro',
    },
  }

  $category_mapping = {
    'aws' => {
      'arm' => 't4g',
      'intel' => 't3',
      'amd' => 't3a',
    },
  }
  return("${category_mapping[$cloud][$architecture]}.${type_mapping[$cloud][$instance_type]}")
}
