class LicenseLinter 

  VALID_FILE = File.open(File.expand_path(File.dirname(__FILE__)) + '/valid_license.md')

  def self.parse_file(file, learn_error)
    directory_file = File.open(file).read
    valid_file = VALID_FILE.read
    if sanitize_whitespace(directory_file) == sanitize_whitespace(valid_file)
      learn_error.license_error[:valid_license] = true
      learn_error.valid_license = {message: "valid license", color: :green}
    end
  end

  def self.sanitize_whitespace(file)
    file.split("\n").delete_if { |l| l.empty? }
  end
end