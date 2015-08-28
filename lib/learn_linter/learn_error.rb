class LearnError < StandardError
  attr_accessor :filepath, :valid_yaml, :valid_license, 
  :present_learn, :present_license, :success, :yaml_error, 
  :license_error, :readme_error

  ESCAPES = { :green  => "\033[32m",
              :yellow => "\033[33m",
              :red    => "\033[31m",
              :reset  => "\033[0m" }


  def initialize
    @yaml_error = {present_dotlearn: false, valid_yaml: false, valid_whitespace: false}
    @readme_error = {present_readme: false, valid_readme: false}
    @license_error = {present_license: false, valid_license: false}
  end

  def emit(opts={})
    color   = opts[:color]
    message = opts[:message]
    print ESCAPES[color]
    print message
    print ESCAPES[:reset]
    print "\n"
  end

  def total_errors
    {
      dot_learn: yaml_error,
      license: license_error,
      readme: readme_error
    }
    
  end


  def result_output
    all_results = [valid_yaml, valid_license, present_learn, present_license].compact!
    all_results.each do |result|
      emit(result)
    end
  end

end