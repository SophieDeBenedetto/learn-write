require 'spec_helper'

FIXTURES_PATH = File.dirname(__FILE__) + '/fixtures/'

describe LearnLinter do
  it 'has a version number' do
    expect(LearnLinter::VERSION).not_to be false
  end

  describe '#lint_directory' do 
    #.learn validations only
    let(:valid_learn) { 
      {:dot_learn => 
        {:present_dotlearn => true, :valid_yaml => true, :valid_whitespace => true, :attributes => true}, 
      :license => 
        {:present_license => false, :valid_license => false}, 
      :readme => 
        {:present_readme => false, :valid_readme => false},
      :contributing =>
        {:present_contributing => false, :valid_contributing => false}
      } 
    }

    let(:present_learn_invalid_yaml){ 
      {:dot_learn => 
        {:present_dotlearn=>true, :valid_yaml=>false, :valid_whitespace=>false, :attributes => false},
      :license => 
        {:present_license=>false, :valid_license=>false},
      :readme => 
        {:present_readme=>false, :valid_readme=>false},
      :contributing =>
        {:present_contributing => false, :valid_contributing => false}
      }
    }

    let(:present_learn_valid_yaml_invalid_whitespace){
      {:dot_learn =>
        {:present_dotlearn=>true, :valid_yaml=>true, :valid_whitespace=>false, :attributes => true},
      :license => 
        {:present_license=>false, :valid_license=>false},
      :readme => 
        {:present_readme=>false, :valid_readme=>false},
      :contributing =>
        {:present_contributing => false, :valid_contributing => false}
      }
    }

    let(:missing_learn) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false, :attributes => false},
      :license => 
        {:present_license=>false, :valid_license=>false},
      :readme => 
        {:present_readme=>false, :valid_readme=>false},
      :contributing =>
        {:present_contributing => false, :valid_contributing => false}
      }
    }

    # license validations only

    let(:valid_license) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false, :attributes => false},
      :license => 
        {:present_license=>true, :valid_license=>true},
      :readme => 
        {:present_readme=>false, :valid_readme=>false},
      :contributing =>
        {:present_contributing => false, :valid_contributing => false}
      }
    }

    let(:invalid_license) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false, :attributes => false},
      :license => 
        {:present_license=>true, :valid_license=>false},
      :readme => 
        {:present_readme=>false, :valid_readme=>false},
      :contributing =>
        {:present_contributing => false, :valid_contributing => false}
      }
    }

    let(:missing_license) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false, :attributes => false},
      :license => 
        {:present_license=>false, :valid_license=>false},
      :readme => 
        {:present_readme=>false, :valid_readme=>false},
      :contributing =>
        {:present_contributing => false, :valid_contributing => false}
      }
    }

    # readme validations only

    let(:missing_readme) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false, :attributes => false},
      :license => 
        {:present_license=>false, :valid_license=>false},
      :readme => 
        {:present_readme=>false, :valid_readme=>false},
      :contributing =>
        {:present_contributing => false, :valid_contributing => false}
      }
    }

    let(:present_and_valid_readme) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false, :attributes => false},
      :license => 
        {:present_license=>false, :valid_license=>false},
      :readme => 
        {:present_readme=>true, :valid_readme=>true},
      :contributing =>
        {:present_contributing => false, :valid_contributing => false}
      }
    }

    let(:invalid_readme) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false, :attributes => false},
      :license => 
        {:present_license=>false, :valid_license=>false},
      :readme => 
        {:present_readme=>true, :valid_readme=>false},
      :contributing =>
        {:present_contributing => false, :valid_contributing => false}
      }
    }

    # contributing validations only

    let(:valid_contributing) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false, :attributes => false},
      :license => 
        {:present_license=>false, :valid_license=>false},
      :readme => 
        {:present_readme=>false, :valid_readme=>false},
      :contributing =>
        {:present_contributing => true, :valid_contributing => true}
      }
    }

    let(:invalid_contributing) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false, :attributes => false},
      :license => 
        {:present_license=>false, :valid_license=>false},
      :readme => 
        {:present_readme=>false, :valid_readme=>false},
      :contributing =>
        {:present_contributing => true, :valid_contributing => false}
      }
    }

    let(:missing_contributing) {
      {:dot_learn =>
        {:present_dotlearn=>false, :valid_yaml=>false, :valid_whitespace=>false, :attributes => false},
      :license => 
        {:present_license=>false, :valid_license=>false},
      :readme => 
        {:present_readme=>false, :valid_readme=>false},
      :contributing =>
        {:present_contributing => false, :valid_contributing => false}
      }
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
        linter = LearnLinter.new(FIXTURES_PATH + 'present_and_valid_readme')
        expect(linter.lint_directory).to eq(present_and_valid_readme)
      end

      it 'reports on a readme with invalid code snippets' do 
        linter = LearnLinter.new(FIXTURES_PATH + 'invalid_readme')
        expect(linter.lint_directory).to eq(invalid_readme)
      end
    end

    context 'when quiet' do 
      it 'does not emit output when given an option of "quiet" ' do 
        linter = LearnLinter.new(FIXTURES_PATH + 'invalid_readme', "quiet")
        expect {linter.lint_directory}.to_not output.to_stdout
      end
    end

    context 'contributing validations' do 
      it 'approves a directory with a valid contributing file' do 
        linter = LearnLinter.new(FIXTURES_PATH + 'valid_contributing')
        expect(linter.lint_directory).to eq(valid_contributing)
      end

      it 'reports on an invalid contribution file' do 
        linter = LearnLinter.new(FIXTURES_PATH + 'invalid_contributing')
        expect(linter.lint_directory).to eq(invalid_contributing)
      end

      it 'reports on a missing contribution file' do 
        linter = LearnLinter.new(FIXTURES_PATH + 'missing_contributing')
        expect(linter.lint_directory).to eq(missing_contributing)
      end
    end

  
  end
end
