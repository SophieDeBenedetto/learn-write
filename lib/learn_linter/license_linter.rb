class LicenseLinter 

  VALID_FILE = File.open(File.expand_path(File.dirname(__FILE__)) + '/valid_license.md')

  def self.parse_file(file, learn_error)
    directory_file = File.open(file)
    if directory_file.read == VALID_FILE.read
      learn_error.license_error[:valid_license] = true
      learn_error.valid_license = {message: "valid license", color: :green}
    end
  end
end