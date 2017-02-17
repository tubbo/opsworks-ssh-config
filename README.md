# Opsworks::Ssh::Config

Generate a `~/.ssh/config` from your OpsWorks stack.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'opsworks-ssh-config'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install opsworks-ssh-config

## Usage

Set the `$AWS_ACCESS_KEY_ID` and `$AWS_SECRET_ACCESS_KEY` variables,
then run the following command to append your opsworks hosts onto your
existing `~/.ssh/config`:

    bundle exec opsworks-ssh-config >> ~/.ssh/config

If you don't already have a file there, run this command to create one:

    bundle exec opsworks-ssh-config > ~/.ssh/config

Now, you can SSH into your hosts by typing `ssh your_opsworks_stack_name_app1`!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Tom Scott/opsworks-ssh-config. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

