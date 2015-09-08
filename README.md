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

From the command line, `gem install learn_linter`.

## Usage

Run from command line with `learn-lint < directory name >`.

Or, from within the directory you want to line, `learn-lint`

To turn off error message output to termina, use `learn-lint <directory name> quiet` or `learn-lint quiet` from within directory you want to lint.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

