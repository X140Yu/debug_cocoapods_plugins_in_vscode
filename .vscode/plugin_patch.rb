Gem::Specification.class_eval do
  class << self
    alias_method :original_latest_specs, :latest_specs
    def latest_specs(latest)
      ret = original_latest_specs(latest)

      plugin_name, plugin_path, gemspec_path = read_config
      $VSCODE_COCOAPODS_DEBUG_PLUGIN_PATH = plugin_path
      specification = Gem::Specification.load(gemspec_path.to_s)
      def specification.full_gem_path
        $VSCODE_COCOAPODS_DEBUG_PLUGIN_PATH
      end

      idx = ret.find_index { |g| g.name == plugin_name }
      if idx
        ret[idx] = specification
      else
        ret << specification
      end
      ret
    end
  end
end

def read_config
  require 'pathname'

  config_path = Pathname.new(File.expand_path('launch.json', __dir__))
  raise 'launch.json does not exist' unless config_path.exist?

  require 'json'
  config_obj = JSON.parse(File.read(config_path))

  plugin_path = Pathname.new(config_obj['configurations'][0]['pluginPath'])
  raise 'pluginPath does not exist' unless plugin_path.exist?

  plugin_name = plugin_path.basename.to_s
  gemspec_path = plugin_path + "#{plugin_name}.gemspec"
  raise 'plugin gemspec does not exist' unless gemspec_path.exist?

  [plugin_name, plugin_path, gemspec_path]
end
