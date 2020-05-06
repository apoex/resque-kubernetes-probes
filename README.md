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

### Download the script in your Dockerfile

The script is simple and checks that the heartbeat file has been updated in the
last `interval` seconds.

```dockerfile
RUN curl -f -o /usr/local/bin/resque_health_check -L "https://raw.githubusercontent.com/apoex/resque-kubernetes-probes/master/bin/resque_health_check" && \
      chmod +x /usr/local/bin/resque_health_check
```

### Resque

The gem hooks into resque's heartbeat logic and by default the heartbeat
interval is quite high (60 seconds). We recommend lowering the default value and
making it configurable through environment variables.

```ruby
Resque.heartbeat_interval = ENV.fetch("RESQUE_HEARTBEAT_INTERVAL", 10).to_i
Resque.prune_interval = Resque.heartbeat_interval * 5
```

```yaml
livenessProbe:
  timeoutSeconds: 1
  periodSeconds: 5
  exec:
    command:
      - resque_health_check
      - tmp/resque_health
```

### Resque Scheduler

The gem does not inject itself into resque-scheduler by default, to do that you
need to add the probe to the list of required files.

```ruby
gem "resque-kubernetes-probes", require: ["resque/kubernetes/probes/resque", "resque/kubernetes/probes/resque-scheduler"]
```

```yaml
livenessProbe:
  timeoutSeconds: 1
  periodSeconds: 5
  exec:
    command:
      - resque_health_check
      - tmp/resque_scheduler_health
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/micke/resque-kubernetes-probes.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
