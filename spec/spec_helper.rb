require "rbsx"
require "yaml"

SPEC_DIR = File.expand_path(File.join("../", __FILE__))
CONFIG = YAML.load_file("spec/config.yml").with_indifferent_access

RSpec.configure do |c|

  c.before(:each) do
    Rbsx.configure do |config|
      config.sx_path = CONFIG.fetch(:sx_path)
      config.private_key = CONFIG.fetch(:private_key)
      config.public_key = CONFIG.fetch(:public_key)
    end
  end

  c.order = "random"

end
