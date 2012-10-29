require "base_config"

module Vh
  # Apache configuration manager
  class ApacheConfig < BaseConfig
    DEFAULT_CONFIG_PATH = '/etc/apache2/extra/httpd-vhosts.conf'

    # Initializes a new instance of this class.
    #
    # @param [String|Pathname] path        The path to the web root.
    # @param [String]          host        The host name to be added.
    # @param [String]          config_path The path to the configuration path
    #                                      (optional, defaults to `DEFAULT_CONFIG_PATH`).
    def initialize(path, host, config_path = DEFAULT_CONFIG_PATH)
      @path        = path
      @host        = host
      @config_path = config_path
    end

    # Performs any necessary checks prior to modifying the configuration file
    # and returns a `Boolean` value indicating whether the checks were successful or not.
    #
    # @return [Boolean]
    def check?
      # Check if the path exists and is a directory
      unless File.directory? @path
        puts "#{@path} is not a valid path."
        return false
      end

      # Check if the configuration file is writable
      unless check_writable?
        puts "The Apache configuration file is not writable by the current user."
        return false
      end

      # Check if there is not already a virtual host defined with the same host name
      unless check_content? /ServerName\s+"#{@host}"/i
        puts "There already is a server named '#{@host}' on the Apache configuration file."
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

# vh - #{@host}
<Directory "#{@path}">
  Allow From All
  AllowOverride All
</Directory>
<VirtualHost *:80>
  ServerName "#{@host}"
  DocumentRoot "#{@path}"
</VirtualHost>
# /vh - #{@host}
      VHOST
    end
  end
end