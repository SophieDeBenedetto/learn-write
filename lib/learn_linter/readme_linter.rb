require 'pry'
class ReadmeLinter

  def self.parse_file(file, learn_error)
    readme = File.open(file).read.split(" ")
    readme.each do |chars|
      if chars.match(/``/)
        if !(chars.match(/```ruby/) || chars.match(/```bash/) || chars.match(/```objc/) || chars.match(/```javascript/) || chars.match(/``` /))
          break
        else
          learn_error.readme_error[:valid_readme] = true
          learn_error.valid_readme = {message: "valid readme", color: :green}
        end
      end
    end
  end
end
    