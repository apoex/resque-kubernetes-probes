class ResqueNotLoadedError < StandardError; end

unless defined?(Resque)
  raise ResqueNotLoadedError, "[resque-kubernetes-probes] resque is not loaded. " \
    "Make sure the resque gem is loaded before `resque-kubernetes-probes` in your Gemfile"
end

module Resque
  class Worker
    alias original_heartbeat! heartbeat!

    def heartbeat!
      FileUtils.touch(File.join(Rails.root, "tmp", "resque_health"))

      original_heartbeat!
    end
  end
end
