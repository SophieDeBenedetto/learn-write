require 'fileutils'
require 'pry'

class LearnWriter

  VALID_DOT_LEARN = File.open(File.expand_path(File.dirname(__FILE__)) + '/learn_writer/valid_dot_learn.yml')
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
    unless Dir.entries(filepath).include?('.learn')
      create_and_write_file(".learn", VALID_DOT_LEARN)
    end
  end

  def write_contributing
    create_and_write_file("CONTRIBUTING.md", VALID_CONTRIBUTING)
  end

  def write_license
    create_and_write_file("LICENSE.md", VALID_LICENSE)
  end

  def create_and_write_file(file_name, file_content)
    file_name = "#{filepath}/#{file_name}"
    file_content = File.read(file_content)
    file = FileUtils.touch(file_name)[0]
    File.open(file, 'w') { |file| file.write(file_content) }
  end
end