# Test Suite Setup

This Rails app is now configured with RSpec, FactoryBot, Capybara, and Selenium - similar to the avvoka_app structure.

## Installed Testing Gems

- **rspec-rails**: Testing framework
- **factory_bot_rails**: Test data factories
- **capybara**: Integration testing
- **selenium-webdriver**: Browser automation for system tests
- **database_cleaner-active_record**: Database cleaning between tests
- **shoulda-matchers**: One-liner matchers for common Rails validations
- **rspec_junit_formatter**: JUnit XML output for CI

## Configuration Files Created

1. **spec/spec_helper.rb** - RSpec core configuration
2. **spec/rails_helper.rb** - Rails-specific RSpec configuration
3. **spec/support/factory_bot.rb** - FactoryBot integration
4. **spec/support/database_cleaner.rb** - Database cleaning strategies
5. **spec/support/capybara.rb** - Capybara and Selenium setup
6. **spec/support/shoulda_matchers.rb** - Shoulda matchers configuration

## Directory Structure

```
spec/
├── factories/        # FactoryBot factory definitions
├── models/          # Model specs
├── controllers/     # Controller specs
├── system/          # System/integration tests (using Capybara + Selenium)
├── requests/        # Request specs
├── helpers/         # Helper specs
└── support/         # Support files and configurations
```

## Running Tests

```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/user_spec.rb

# Run system tests with visible browser (for debugging)
SHOW_BROWSER=1 bundle exec rspec spec/system/

# Run tests with documentation format
bundle exec rspec --format documentation

# Run tests matching a pattern
bundle exec rspec spec/models/
```

## System Tests with Selenium

System tests run in headless Chrome by default. To see the browser:
```bash
SHOW_BROWSER=1 bundle exec rspec spec/system/
```

## Database Cleaner

- Uses transaction strategy for regular tests (fast)
- Uses truncation strategy for system tests (necessary for Selenium)
- Automatically configured in `spec/support/database_cleaner.rb`

## Next Steps

1. Write your tests in the appropriate directories
2. Create factories in `spec/factories/`
3. System tests go in `spec/system/` for full browser testing
4. Model tests in `spec/models/`
5. Controller tests in `spec/controllers/` or use request specs in `spec/requests/`