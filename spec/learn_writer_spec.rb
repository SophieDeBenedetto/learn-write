require 'spec_helper'

describe LearnWriter do
  before do
    reset_fixtures
  end

  after(:each) do
   reset_fixtures
  end

  describe "#write_metadata" do
    it "does not overwrite an existing .learn file" do
      LearnWriter.new(PRESENT_DOT_LEARN).write_metadata
      directory = Dir.entries(PRESENT_DOT_LEARN)
      dot_learn_content = File.read(PRESENT_DOT_LEARN + '/.learn').split(" ")
      expect(directory).to include(".learn")
      expect(directory).to include("CONTRIBUTING.md")
      expect(directory).to include("LICENSE.md")
      expect(dot_learn_content).to include("SQL")
    end

    it "does not overwrite an existing .editorconfig file" do
      LearnWriter.new(PRESENT_DOT_EDITORCONFIG).write_metadata
      dot_editorconfig_content = File.read(PRESENT_DOT_EDITORCONFIG + '/.editorconfig').split(' ')
      expect(dot_editorconfig_content).to include("[*.foo]")
    end

    it "does not overwrite an existing .gitignore file" do
      LearnWriter.new(PRESENT_DOT_GITIGNORE).write_metadata
      dot_gitignore_content = File.read(PRESENT_DOT_GITIGNORE + '/.gitignore')
      expect(dot_gitignore_content).to include("*.bar")
    end

    it "adds new .editorconfig, .gitignore, .learn, contributing, and license files" do
      LearnWriter.new(MISSING_ALL_FILES).write_metadata
      directory = Dir.entries(MISSING_ALL_FILES)
      expect(directory).to include(".editorconfig")
      expect(directory).to include(".gitignore")
      expect(directory).to include(".learn")
      expect(directory).to include("CONTRIBUTING.md")
      expect(directory).to include("LICENSE.md")
      expect(directory).to include("random_file.rb")
    end
  end
end
