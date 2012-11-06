require "vh/apache_installer"
require "vh/apache_config"
require "vh/hosts_config"
require "vh/apache_handler"

# Virtual Hosts Manager driver
module Vh
  # Adds a virtual host to the currently-existing ones.
  #
  # Example:
  #   >> Vh.add "~/dev/project/web", "project.local"
  #
  # @param  [String|Pathname] path     The local path for the web root.
  # @param  [String]          hostname The host name for the virtual host.
  #
  # @return [Vh]
  def self.add(path, hostname)
    # Check and install if necessary the configuration on the web server
    self.install

    # Add the host to the Apache configuration
    apache_config = ApacheConfig.new path, hostname
    apache_config.run

    # Add the hostname alias to the hosts file
    hosts_config = HostsConfig.new hostname
    hosts_config.run

    # Restart Apache
    apache_handler = ApacheHandler.new
    apache_handler.run

    return self
  end

  # Installs - if necessary - the initial configuration needed
  # for the Virtual Hosts to be properly included in the Apache
  # configuration.
  #
  # @return [Vh]
  def self.install
    # Install the Apache configuration include
    apache_installer = ApacheInstaller.new
    apache_installer.run

    return self
  end
end