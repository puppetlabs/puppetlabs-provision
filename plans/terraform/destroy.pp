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
# @param profile
#   The name of the profile to be used for provisioning
#
# @param image
#   The cloud image that is used for new instance provisioning, format differs
#   depending on provider
#
plan provision::terraform::destroy(
  String[1]                    $tf_dir,
  String[1]                    $resource_name = undef,
  String[1]                    $profile       = undef,
  String[1]                    $image         = undef,
  Optional[String[1]]          $region        = undef,
) {
  out::message('Initializing Terraform to destroy provisioned infrastructure')
  run_task('terraform::initialize', 'localhost', dir => $tf_dir)

  $vars_template = @(TFVARS)
    resource_name = <%= $resource_name %>
    <% unless $region == undef { -%>
    region        = "<%= $region %>"
    <% } -%>
    image         = "<%= $image %>"
    # Required parameters which values are irrelevant on destroy
    profile       = "<%= $profile %>"
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
