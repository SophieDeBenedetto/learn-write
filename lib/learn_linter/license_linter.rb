class LicenseLinter 

  def self.parse_file(file, learn_error)
    directory_file = File.open(file)
    valid_file = File.open(File.expand_path(File.dirname(__FILE__)) + '/valid_license.md')
    if directory_file.read == valid_file.read
      learn_error.license_error[:valid_license] = true
      learn_error.valid_license = {message: "valid license", color: :green}
    end
  end
end