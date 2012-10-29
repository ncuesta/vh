module Vh
  # Base class for all configuration managers
  class BaseConfig
    # Checks if the configuration path stored in `@config_path`
    # is writable and returns a boolean value representing the
    # outcome of that check.
    #
    # @return [Boolean]
    def check_writable?
      File.writable? @config_path
    end

    # Checks if the configuration file at `@config_path`
    # does not match a `regex` and returns `true` if
    # there is no match or `false` otherwise.
    #
    # @param  [Regexp] regex The regular expression to check `@config_path` against.
    #
    # @return [Boolean]
    def check_content?(regex)
      open @config_path do | config |
        config.grep(regex).length == 0
      end
    end

    # Appends `content` to the configuration file at `@config_path`
    #
    # @param [String] content The content to append to the configuration file.
    def append_to_config(content)
      open @config_path, 'a+' do | config |
        config << content
      end
    end

    # Runs the manager: mainly, append the new configuration generated
    # by {#new_config} if the checks are OK.
    #
    # (see #append_to_config)
    # (see #check?)
    # (see #new_config)
    def run
      append_to_config new_config_content if check?
    end

    # Generates the new content that will be appended to the configuration file.
    #
    # @return [String]
    def new_config_content
      raise NotImplementedError
    end
  end
end