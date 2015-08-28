require 'yaml'

class YamlLint

  def self.parse_file(file, learn_error)
    begin
      YAML.load_file(file)
    rescue Exception => err
      learn_error.valid_yaml = {message: "#{err}", color: :red}
    else
      learn_error.yaml_error[:valid_yaml] = true
      if self.validate_whitespace_for_learn(file)
        learn_error.yaml_error[:valid_whitespace] = true
        learn_error.valid_yaml = {message: "valid yaml and valid whitespace.", color: :green}
      else 
        learn_error.valid_yaml = {message: "valid yaml but invalid whitespace", color: :red}
      end
    end
  end

  def self.validate_whitespace_for_learn(file)
    f = File.read(file)
    lines = f.split("\n")
    attributes = lines.select { |line| line.include?("-") }
    attributes.each do |attribute| 
      return false unless attribute[0..3] == "  - "
    end
    true
  end 

end
