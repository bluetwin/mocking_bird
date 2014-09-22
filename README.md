# MockingBird

This is a singleton class that helps auto load json_api_client_mocks.

Pain point:
Setting up client mocks for json_api_client tests can be messy with situations like:

```ruby
MyApi::Client::User.set_test_results([some data...], {<some conditions...>)
MyApi::Client::User.set_test_results([some data...], {<some conditions...>)
MyApi::Client::User.set_test_results([some data...], {<some conditions...>)
MyOtherApi::Client::Customer.set_test_results([some data...], {<some conditions...>)
MyOtherApi::Client::Customer.set_test_results([some data...], {<some conditions...>)
MyOtherApi::Client::Customer.set_test_results([some data...], {<some conditions...>)
```
Placing this anywhere is ugly and time consuming.

MockingBird attempts to combine this into a more fixture-like convention by using the file structure of your
mocks to build client based test results that are accessible, or just trying to mimic fixtures.

## Installation

Add this line to your application's Gemfile:

    gem 'mocking_bird'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mocking_bird

## Usage

  #### File System Structure

                      In your mock directory you would create the following structure:

                      ```
                      |
                      |-mocks
                        |-my_api
                          |-customer
                            create.yml
                            delete.yml
                            read.yml
                            update.yml
                          |-user
                            create.yml
                            delete.yml
                            read.yml
                            update.yml
                        |-my_other_api
                            |-order
                              create.yml
                              delete.yml
                              read.yml
                              update.yml
                            |-invocie
                              create.yml
                              delete.yml
          read.yml
          update.yml
  ```

  This will load mocks for `MyApi::Client::Customer, MyApi::Client::User, MyOtherApi::Client::Order, and MyOtherApi::Client::Invoice`
  The mock files are grouped by action, but you can name them anything and they will be accessible by this actions(shown later).

  ### currently only YAMl files are accepted, with JSON coming soon.

  #### Mock File Structure

  The file structure for each mock file is:

  ```yaml
  # user/create.yml
  <mock_name>:
    conditions:
        name: 'test_uers'
      response:
        id: 1
        name: 'test_uers'
  ```

  Example:

  ```yaml
  # my_api/users/create.yml
  test_user:
    conditions:
      name: 'test_uers'
      contact: 'test user'
      email_address: 'test@test.com'
      phone_number: '2062222222'
      address_id: nil
      credit_cards: []
      address:
        address_line1: '111 test ave'
        addresS_line2: ''
        city: 'Seattle'
        state: 'WA'
        count: nil
        postal_code: '98109'
    response:
      id: 1
      name: 'test_uers'
      contact: 'test user'
      email_address: 'test@test.com'
      phone_number: '2062222222'
      address_id: nil
      credit_cards: []
      address:
        id: 1
        address_line1: '111 test ave'
        addresS_line2: ''
        city: 'Seattle'
        state: 'WA'
        count: nil
        postal_code: '98109'
  ```

  #### Building the mocks

  Setting up the mocks is done by calling

  ```ruby
  MockingBird::setup_mocks(:path => Rails.root.join('test','mocks')
  ```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mocking_bird/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
=======
mocking_bird
============

Mock manager for json_api_client_mocks

