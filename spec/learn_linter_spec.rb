require 'spec_helper'

FIXTURES_PATH = File.dirname(__FILE__) + '/fixtures/'

describe LearnLinter do
  it 'has a version number' do
    expect(LearnLinter::VERSION).not_to be nil
  end

  describe '#lint_direcoty' do 

  #.learn validations only
    let(:valid_learn) { 
      {:dot_learn => 
        {:present_dotlearn => true, :valid_yaml => true, :valid_whitespace => true}, 
      :license => 
        {:present_license => false, :valid_license => false}, 
      :readme => 
        {:present_readme => false, :valid_readme => false}} 
    }

    let(:present_learn_invalid_yaml){ 
      {:dot_learn => 
        {:present_dotlearn=>true, :valid_yaml=>false, :valid_whitespace=>false},
      :license => 
      {:present_license=>false, :valid_license=>false},
      :readme => 
      {:present_readme=>false, :valid_readme=>false}}
    }

    let(:present_learn_valid_yaml_invalid_whitespace){
      {:dot_learn =>
        {:present_dotlearn=>true, :valid_yaml=>true, :valid_whitespace=>false},
      :license => 
        {:present_license=>false, :valid_license=>false},
      :readme => 
        {:present_readme=>false, :valid_readme=>false}}
    }

    let(:missing_learn) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false},
      :license => 
        {:present_license=>false, :valid_license=>false},
      :readme => 
        {:present_readme=>false, :valid_readme=>false}}

    }

    let(:valid_license) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false},
      :license => 
        {:present_license=>true, :valid_license=>true},
      :readme => 
        {:present_readme=>false, :valid_readme=>false}}
    }

    let(:invalid_license) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false},
      :license => 
        {:present_license=>true, :valid_license=>false},
      :readme => 
        {:present_readme=>false, :valid_readme=>false}}
    }

    let(:missing_license) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false},
      :license => 
        {:present_license=>false, :valid_license=>false},
      :readme => 
        {:present_readme=>false, :valid_readme=>false}}
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
  end
end


