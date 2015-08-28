require 'spec_helper'

FIXTURES_PATH = File.dirname(__FILE__) + '/fixtures/'

describe LearnLinter do
  it 'has a version number' do
    expect(LearnLinter::VERSION).not_to be nil
  end

  describe '#lint_directory' do 

  #.learn validations only
    let(:valid_learn) { 
      {:dot_learn => 
        {:present_dotlearn => true, :valid_yaml => true, :valid_whitespace => true}, 
      :license => 
        {:present_license => false, :valid_license => false}, 
      :readme => 
        {:present_readme => false, :valid_readme => nil}} 
    }

    let(:present_learn_invalid_yaml){ 
      {:dot_learn => 
        {:present_dotlearn=>true, :valid_yaml=>false, :valid_whitespace=>false},
      :license => 
      {:present_license=>false, :valid_license=>false},
      :readme => 
      {:present_readme=>false, :valid_readme=>nil}}
    }

    let(:present_learn_valid_yaml_invalid_whitespace){
      {:dot_learn =>
        {:present_dotlearn=>true, :valid_yaml=>true, :valid_whitespace=>false},
      :license => 
        {:present_license=>false, :valid_license=>false},
      :readme => 
        {:present_readme=>false, :valid_readme=>nil}}
    }

    let(:missing_learn) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false},
      :license => 
        {:present_license=>false, :valid_license=>false},
      :readme => 
        {:present_readme=>false, :valid_readme=>nil}}

    }

    # license validations only

    let(:valid_license) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false},
      :license => 
        {:present_license=>true, :valid_license=>true},
      :readme => 
        {:present_readme=>false, :valid_readme=>nil}}
    }

    let(:invalid_license) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false},
      :license => 
        {:present_license=>true, :valid_license=>false},
      :readme => 
        {:present_readme=>false, :valid_readme=>nil}}
    }

    let(:missing_license) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false},
      :license => 
        {:present_license=>false, :valid_license=>false},
      :readme => 
        {:present_readme=>false, :valid_readme=>nil}}
    }

    # readme validations only

    let(:missing_readme) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false},
      :license => 
        {:present_license=>false, :valid_license=>false},
      :readme => 
        {:present_readme=>false, :valid_readme=>nil}}
    }

     let(:present_readme) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false},
      :license => 
        {:present_license=>false, :valid_license=>false},
      :readme => 
        {:present_readme=>true, :valid_readme=>nil}}
    }


    context '.learn validations' do 
      it 'approves directory with valid .learn file' do 
        linter = LearnLinter.new(FIXTURES_PATH + 'valid_learn')
        expect(linter.lint_directory).to eq(valid_learn)
      end

      it 'reports on invalid yaml in a .learn file' do 
        linter = LearnLinter.new(FIXTURES_PATH + 'present_learn_invalid_yaml')
        expect(linter.lint_directory).to eq(present_learn_invalid_yaml)
      end

      it 'reports on invalid whitespace in a .learn file' do 
        linter = LearnLinter.new(FIXTURES_PATH + 'present_learn_valid_yaml_invalid_whitespace')
        expect(linter.lint_directory).to eq(present_learn_valid_yaml_invalid_whitespace)
      end

      it 'reports on a missing .learn file' do 
        linter = LearnLinter.new(FIXTURES_PATH + 'missing_learn')
        expect(linter.lint_directory).to eq(missing_learn)
      end
    end

    context 'license validations' do 
      it 'approves a directory with a valid license' do 
        linter = LearnLinter.new(FIXTURES_PATH + 'valid_license')
        expect(linter.lint_directory).to eq(valid_license)
      end

      it 'reports on an invalid license' do 
        linter = LearnLinter.new(FIXTURES_PATH + 'invalid_license')
        expect(linter.lint_directory).to eq(invalid_license)
      end

      it 'reports on a missing license' do 
        linter = LearnLinter.new(FIXTURES_PATH + 'missing_license')
        expect(linter.lint_directory).to eq(missing_license)
      end
    end

    context 'readme validations' do 
      it 'reports on a missing README.md' do 
        linter = LearnLinter.new(FIXTURES_PATH + 'missing_readme')
        expect(linter.lint_directory).to eq(missing_readme)
      end

      it 'approves a directory that contains a README.md' do 
        linter = LearnLinter.new(FIXTURES_PATH + 'present_readme')
        expect(linter.lint_directory).to eq(present_readme)
      end
    end
  end
end


