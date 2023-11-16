Puppet::Functions.create_function(:'provision::get_gcp_profile') do
  dispatch :get_gcp_profile do
    required_param 'String[1]', :project
    return_type 'String'
  end

  def get_gcp_profile(project)
    project_error_message = 'Project is required for Google Cloud Provider'
    raise Puppet::ParseError, project_error_message if project.nil? || project.empty?

    set_profile
  end

  private

  def set_profile
    google_credentials = ENV['GOOGLE_CREDENTIALS']
    google_application_credentials = ENV['GOOGLE_APPLICATION_CREDENTIALS']

    credentials_error_message = 'GOOGLE_CREDENTIALS or GOOGLE_APPLICATION_CREDENTIALS environment variable is required for Google Cloud Provider'
    raise Puppet::ParseError, credentials_error_message if google_credentials.nil? && google_application_credentials.nil?

    google_credentials || google_application_credentials
  end
end
