# frozen_string_literal: true

# @summary
#   The function to map the human readable instance type to the Cloud provider instance type
#
# @param cloud
#   The type of cloud provider
#
# @param architecture
#   The architecture of the image
#
# @return [String]
#  The type of architecture of the image
#
function provision::map_image_architecture(
  Provision::CloudProvider $cloud,
  Provision::Architecture $architecture
) >> String {
  $mapping = {
    'aws' => {
      'arm' => 'arm64',
      'amd' => 'x86_64',
      'intel' => 'x86_64',
    },
  }
  return($mapping[$cloud][$architecture])
}
