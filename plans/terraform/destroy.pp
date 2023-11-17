# This plan isn't shown in plan list output
# @api private
#
# @summary Destroy a earlier provisioned virtual machine using terraform
#
# @param tf_dir
#   Terraform directory where the plan is located
#
# @param region
#   Which region to provision infrastructure in, if not provided default will
#   be determined by provider
#
# @param resource_name
#   The name of the resource to be provisioned on respective cloud provider
#
# @param provider
#   The cloud provider to use for provisioning, valid values are 'aws', 'azure' and 'gcp'
#
plan provision::terraform::destroy(
  String[1]                    $tf_dir,
  String[1]                    $provider,
  String[1]                    $resource_name,
  Optional[String[1]]          $region        = undef,
  Optional[Provision::ProviderOptions] $provider_options = undef,
  Optional[String[1]]          $project            = undef,
) {
  out::message('Initializing Terraform to destroy provisioned infrastructure')
  run_task('terraform::initialize', 'localhost', dir => $tf_dir)

  if $provider == 'gcp' {
    $profile = provision::gcp_profile()
  }

  $vars_template = @(TFVARS)
    name = "<%= $resource_name %>"
    <% unless $region == undef { -%>
    region        = "<%= $region %>"
    <% } -%>
    # Required parameters which values are irrelevant on destroy
    <%- if $provider == 'gcp' { -%>
    profile       = "<%= $profile %>"
    <%- } -%>
    <% unless $project == undef { -%>
    project       = "<%= $project %>"
    <% } -%>
    |TFVARS

  $tfvars = inline_epp($vars_template)

  provision::with_tempfile_containing('', $tfvars, '.tfvars') |$tfvars_file| {
    # Stands up our cloud infrastructure that we'll install PE onto, returning a
    # specific set of data via TF outputs that if replicated will make this plan
    # easily adaptable for use with multiple cloud providers
    run_plan('terraform::destroy',
      dir           => $tf_dir,
      var_file      => $tfvars_file,
      state     => "${resource_name}.tfstate",
    )
  }
}
