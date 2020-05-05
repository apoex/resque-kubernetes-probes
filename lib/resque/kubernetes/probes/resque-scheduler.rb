unless defined?(Resque::Scheduler)
  raise ResqueNotLoadedError, "[resque-kubernetes-probes] resque-scheduler is not loaded. " \
    "Make sure the resque-scheduler gem is loaded before `resque-kubernetes-probes` in your Gemfile"
end

module Resque
  module Scheduler
    class << self
      alias original_poll_sleep poll_sleep

      def poll_sleep
        FileUtils.touch(File.join(Rails.root, "tmp", "resque_scheduler_health"))

        original_poll_sleep
      end
    end
  end
end
