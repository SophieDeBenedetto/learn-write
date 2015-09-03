# LearnLinter

Gem to accompany Learn curriculum development. Install gem and run from command line with `learn-lint < directory name >`. Given a directory, the gem will lint for 

* precense of `.learn` file
* valid yaml in `.learn` file
* valid whitespace for Learn in `.learn` file. Learn requires two whitespace before a `-` in any lines containing a `-`. 
* precense of `LICENSE.md`
* valid license content in that file. 
* precense of `README.md`
* valid code snippets in `README.md`


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'learnlinter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install learnlinter

## Usage

Run from command line with `learn-lint < directory name >`.

To turn off error message output to termina, use `learn-lint <directory name> quiet`


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

