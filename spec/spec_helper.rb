$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'learn_writer'

FIXTURES_PATH = File.dirname(__FILE__) + '/fixtures/'
MISSING_ALL_FILES = FIXTURES_PATH + 'missing_all_files'
PRESENT_DOT_EDITORCONFIG = FIXTURES_PATH + 'present_dot_editorconfig'
PRESENT_DOT_GITIGNORE = FIXTURES_PATH + 'present_dot_gitignore'
PRESENT_DOT_LEARN = FIXTURES_PATH + 'present_dot_learn'
UNLINK_EXCLUSIONS = ['.', '..']

def reset_fixtures
  editorconfig_dir, gitignore_dir, learn_dir, missing_all_dir = [
    PRESENT_DOT_EDITORCONFIG,
    PRESENT_DOT_GITIGNORE,
    PRESENT_DOT_LEARN,
    MISSING_ALL_FILES,
  ].map do |dir|
    Dir.entries(dir) - UNLINK_EXCLUSIONS
  end

  editorconfig_dir.each do |f|
    FileUtils.rm("#{PRESENT_DOT_EDITORCONFIG}/#{f}") unless f == ".editorconfig"
  end

  gitignore_dir.each do |f|
    FileUtils.rm("#{PRESENT_DOT_GITIGNORE}/#{f}") unless f == ".gitignore"
  end

  learn_dir.each do |f|
    FileUtils.rm("#{PRESENT_DOT_LEARN}/#{f}") unless f == ".learn"
  end

  missing_all_dir.each do |f|
    FileUtils.rm("#{MISSING_ALL_FILES}/#{f}") unless f == "random_file.rb"
  end
end
