require 'spec_helper'

FIXTURES_PATH = File.dirname(__FILE__) + '/fixtures/'
PRESENT_DOT_LEARN = FIXTURES_PATH + 'present_dot_learn'
MISSING_ALL_FILES = FIXTURES_PATH + 'missing_all_files'

describe LearnWriter do 

  after(:each) do 
    FileUtils.rm_rf ["#{PRESENT_DOT_LEARN}/CONTRIBUTING.md", "#{PRESENT_DOT_LEARN}/LICENSE.md"]
    FileUtils.rm_rf ["#{MISSING_ALL_FILES}/.learn", "#{MISSING_ALL_FILES}/CONTRIBUTING.md", "#{MISSING_ALL_FILES}/LICENSE.md"]
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

    it "adds a new .learn, contributing and license file" do 
      LearnWriter.new(MISSING_ALL_FILES).write_metadata
      directory = Dir.entries(MISSING_ALL_FILES)
      expect(directory).to include(".learn")
      expect(directory).to include("CONTRIBUTING.md")
      expect(directory).to include("LICENSE.md")
    end
  end
end


