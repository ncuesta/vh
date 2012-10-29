module Vh
  # Apache server handler
  class ApacheHandler
    DEFAULT_APACHE_COMMAND = "apachectl"

    # Initializes a new instance of this class.
    #
    # @param [String] apache_command The command to use to handle Apache
    #                                (Optional, defaults to DEFAULT_APACHE_COMMAND).
    def initialize(apache_command = DEFAULT_APACHE_COMMAND)
      @apachectl = apache_command
    end

    # Runs this handler - Restarts Apache server
    def run
      `#{@apachectl} restart`
    end
  end
end