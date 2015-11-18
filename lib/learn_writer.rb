require 'fileutils'

class LearnWriter

  VALID_CONTRIBUTING = File.open(File.expand_path(File.dirname(__FILE__)) + '/learn_writer/valid_contributing.md')
  VALID_LICENSE = File.open(File.expand_path(File.dirname(__FILE__)) + '/learn_writer/valid_license.md')
  
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
    FileUtils.touch(dot_learn)
  end

  def write_contributing
    contributing = "#{filepath}/CONTRIBUTING.md"
    contributing_content = File.read(VALID_CONTRIBUTING)
    file = FileUtils.touch(contributing)[0]
    File.open(file, 'w') { |file| file.write(contributing_content) }
  end

  def write_license
    license = "#{filepath}/LICENSE.md"
    license_content = File.read(VALID_LICENSE)
    file = FileUtils.touch(license)[0]
    File.open(file, 'w') { |file| file.write(license_content) }

  end
end