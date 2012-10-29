require "vh/base_config"

module Vh
  # Hosts aliases configuration manager
  class HostsConfig < BaseConfig
    DEFAULT_CONFIG_PATH = '/etc/hosts'

    # Initializes a new instance of this class.
    #
    # @param [String] hostname    The hostname to be added.
    # @param [String] ip          The IP address to use (optional, defaults to `'127.0.0.1'`).
    # @param [String] config_path The path to the configuration path (optional, defaults to `DEFAULT_CONFIG_PATH`).
    def initialize(hostname, ip = '127.0.0.1', config_path = DEFAULT_CONFIG_PATH)
      @hostname    = hostname
      @ip_address  = ip
      @config_path = config_path
    end

    # Performs any necessary checks prior to modifying the configuration file
    # and returns a `Boolean` value indicating whether the checks were successful or not.
    #
    # @return [Boolean]
    def check?
      # Check if the configuration file is writable
      unless check_writable?
        puts "You don't have the required permissions to modify hosts configuration file."
        return false
      end

      # Check if there is not already a host defined with the same name
      unless check_content? /\W#{@hostname}\W/i
        puts "There already is a host named '#{@hostname}'."
        return false
      end

      # Success! :)
      return true
    end

    # Generates the new content that will be appended to the configuration file.
    #
    # @return [String]
    def new_config_content
      return "\n#{@ip_address} #{@hostname} # vh"
    end
  end
end