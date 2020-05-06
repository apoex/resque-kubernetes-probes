# Resque::Kubernetes::Probes

This gem injects code into Resque and Resque::Scheduler that touches a file in
the `tmp` directory `resque_health` for Resque and `resque_scheduler_health` for
Resque::Scheduler. These files can then be used by the Kubernetes liveness
probes to check that the worker and scheduler is running properly.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'resque-kubernetes-probes'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install resque-kubernetes-probes

## Usage

### Resque

```yaml
livenessProbe:
  timeoutSeconds: 3
  periodSeconds: 5
  exec:
    command:
      - test
      - -n
      - "$(find tmp/resque_health -mtime -${RESQUE_HEARTBEAT_INTERVAL:-60}s)"
```

### Resque Scheduler

```yaml
livenessProbe:
  timeoutSeconds: 3
  periodSeconds: 5
  exec:
    command:
      - test
      - -n
      - "$(find tmp/resque_scheduler_health -mtime -${RESQUE_SCHEDULER_INTERVAL:-5}s)"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/micke/resque-kubernetes-probes.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
