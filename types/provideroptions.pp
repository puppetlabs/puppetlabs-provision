#
# @summary
#   This custom type is used to manage the list of provider specific parameters.
#
type Provision::ProviderOptions = Hash[String[1], Variant[String[1], Integer, Boolean]]
