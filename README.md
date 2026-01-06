# SampleSocial

## About This Project

This project is originally based on the sample application for the Ruby on Rails Tutorial: Learn Web Development with Rails by Michael Hartl. The original repository can be found at: https://github.com/learnenough/rails_tutorial_sample_app_7th_ed

Original License: All source code in the original Ruby on Rails Tutorial is available jointly under the MIT License and the Beerware License. See [LICENSE.md](LICENSE.md) for details.

## Getting started

To get started with the app, clone the repo and then install the needed gems. You can clone the repo as follows:

```
$ git clone https://github.com/learnenough/rails_tutorial_sample_app_7th_ed 
$ cd rails_tutorial_sample_app_7th_ed/
```

To install the gems, you will need the same versions of Ruby and Bundler used to build the sample app, which you can find using the `cat` and `tail` commands as follows:

```
$ cat .ruby-version
<Ruby version number>
$ tail -n1 Gemfile.lock
   <Bundler version number>
```

Next, install the versions of `ruby` and the `bundler` gem from the above commands. The Ruby installation is system-dependent; on the cloud IDE recommended in the tutorial, it can be installed as follows:

```
$ rvm get stable
$ rvm install <Ruby version number>
$ rvm --default use <Ruby version number>
```

See the section [Up and running](https://www.learnenough.com/ruby-on-rails-7th-edition-tutorial#sec-up_and_running) for more details. Once Ruby is installed, the `bundler` gem can be installed using the `gem` command:

```
$ gem install bundler -v <version number>
```

Then the rest of the necessary gems can be installed with `bundle` (taking care to skip any production gems in the development environment):

```
$ bundle _<version number>_ config set --local without 'production'
$ bundle _<version number>_ install
```

Here you should replace `<version number>` with the actual version number. For example, if `<version number>` is `2.3.14`, then the commands should look like this:

```
$ gem install bundler -v 2.3.14
$ bundle _2.3.14_ config set --local without 'production'
$ bundle _2.3.14_ install
```

If you run into any trouble, you can remove `Gemfile.lock` and rebundle at any time:

```
$ rm -f Gemfile.lock
$ bundle install
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, you'll be ready to seed the database with sample users and run the app in a local server:

```
$ rails db:seed
$ rails server
```

Follow the instructions in [Section 1.2.2 `rails server`](https://www.railstutorial.org/book#sec-rails_server) to view the app. You can then register a new user or log in as the sample administrative user with the email `example@railstutorial.org` and password `foobar`.

## Test Suite

> 📋 **Testing Documentation Available!**  
> For detailed information about running tests and understanding the testing setup, please see **[TEST_SETUP.md](TEST_SETUP.md)**

### Testing Stack

- **RSpec Rails (6.1.5)**
- **Capybara (3.40.0)**
- **Selenium WebDriver (4.32.0)**
- **Factory Bot Rails (6.5.0)**
- **Shoulda Matchers (5.3.0)**
- **Database Cleaner (2.2.2)**

### Quick Test Commands

```bash
# Run all tests
$ bundle exec rspec

# Run specific test file
$ bundle exec rspec spec/models/user_spec.rb

# Run tests with documentation format
$ bundle exec rspec --format documentation
```

For complete testing documentation including setup instructions, configuration details, and testing best practices, refer to **[TEST_SETUP.md](TEST_SETUP.md)**.