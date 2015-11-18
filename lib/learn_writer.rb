require 'fileutils'

class LearnWriter

  VALID_CONTRIBUTING = File.open(File.expand_path(File.dirname(__FILE__)) + '/valid_contributing.md')
  VALID_LICENSE = File.open(File.expand_path(File.dirname(__FILE__)) + '/valid_license.md')
  
  attr_accessor :filepath

  def initialize(filepath)
    @filepath = filepath
  end

  def write_metadata
    write_dot_learn
    write_contributing
    write_license
  end

  def write_dot_learn
    dot_learn = "#{filepath}/.learn"
    File.new(dot_learn)
  end

  def write_contributing
    contributing = "#{filepath}/CONTRIBUTING.md"
    contributing_content = File.read(VALID_CONTRIBUTING)
    File.new(contributing, 'w') { |file| file.write(contributing_content) }
  end

  def write_license
    license = "#{filepath}/LICENSE.md"
    license_content = File.read(VALID_LICENSE)
    File.new(license, 'w') { |file| file.write(license_content) }

  end
end