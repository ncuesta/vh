require "vh/base_config"
require "vh/apache_config"

module Vh
  # Apache installation manager
  class ApacheInstaller < BaseConfig
    DEFAULT_CONFIG_PATH = "/etc/apache2/httpd.conf"

    # Initializes a new instance of this class.
    #
    # @param [String] target_path The path to the vh configuration file that will be included by Apache.
    # @param [String] config_path The path to the configuration path (optional, defaults to `DEFAULT_CONFIG_PATH`).
    def initialize(target_path = ApacheConfig::DEFAULT_CONFIG_PATH, config_path = DEFAULT_CONFIG_PATH)
      @target      = Pathname.new(target_path).realpath.to_s
      @config_path = config_path
    end

    # Performs any necessary checks prior to modifying the configuration file
    # and returns a `Boolean` value indicating whether the checks were successful or not.
    #
    # @return [Boolean]
    def check?
      # Check if the configuration path exists and is a file
      unless File.exists? @config_path
        puts "#{@config_path} is not a valid path."
        return false
      end

      # Check if the configuration file is writable
      unless check_writable?
        puts "The Apache configuration file (#{@config_path}) is not writable by the current user."
        return false
      end

      # Check if there is not already a virtual host defined with the same host name
      unless check_content? /^\s*Include\s+#{@target}$/i
        puts "The target configuration file (#{@target}) is already being included by Apache."
        return false
      end

      # Success! :)
      return true
    end

    # Generates the new content that will be appended to the configuration file.
    #
    # @return [String]
    def new_config_content
      return <<-VHOST

# vh configuration file
Include #{@target}
# /vh configuration file
      VHOST
    end
  end
end