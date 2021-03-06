# Tiller data source base class.
module Tiller
  # Subclasses provide global_values and/or values (things local to a specific
  # template) and target_values (meta data about a template, e.g. target
  # location, permissions, owner and so on)
  class DataSource
    # All subclasses get this, which is a hash containing tiller_base,
    # tiller_lib and environment.
    @config = Array.new

    def initialize(config)
      @config = config
      setup
    end

    # This is where any post-initialisation logic happens
    # (connecting to a database etc.)
    def setup
    end

    # This is where we override any of the common.yaml settings per environment.
    # EG, the exec: parameter and so on.
    def common
      {}
    end

    def global_values
      {}
    end

    # We should always return a hash; if we have no data for the given
    # template, just return an empty hash.
    def values(_template_name)
      {}
    end

    # This should provide a hash similar to this example :
    # {
    #    'target'  => "/tmp/#{template_name}",
    #    'user'    => 'root',
    #    'group'   => 'root',
    #    'perms'   => '0644'
    # }
    # Again, we should always return a hash; if we have no data for the given
    # template, just return an empty hash.
    def target_values(_template_name)
      {}
    end

    def ping
      'ping!' + @config.to_s
    end
  end
end
