# @summary
#   Creates a temporary file on the local machine which initiated pecdm and cleans
#   it up when the code requiring the file completes
#
# @param [String] name
#   The name of file to create temporary on filesystem
#
# @param [String] contents
#   The contents of the file to be created
#
# @param [String] extension
#  The extension of the file to be created
#
# @param [Callable[1, 1]] block
#  The block of code to be executed with the temporary file
#
require 'tempfile'
Puppet::Functions.create_function(:'provision::with_tempfile_containing') do
  dispatch :with_tempfile_containing do
    param 'String', :name
    param 'String', :contents
    param 'Optional[String]', :extension
    block_param 'Callable[1, 1]', :block
  end

  def with_tempfile_containing(name, contents, extension = nil)
    params = if extension
               [name, extension]
             else
               name
             end

    puts "with_tempfile_containing: #{params}"
    Tempfile.open(params) do |file|
      file.binmode # Stop Ruby implicitly doing CRLF translations and breaking tests
      file.write(contents)
      file.flush
      yield file.path
    end
  end
end
