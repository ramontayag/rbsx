require "active_support/core_ext/module/attribute_accessors"
require "active_support/core_ext/hash/indifferent_access"
require "rbsx/version"
require "rbsx/client"
require "rbsx/exceptions"

module Rbsx

  CONFIG_ATTRS = %i[sx_path]
  mattr_accessor(*CONFIG_ATTRS)

  def self.new(args={})
    config = CONFIG_ATTRS.inject({}) do |hash, config_attr|
      hash[config_attr] = args[config_attr] || Rbsx.send(config_attr)
      hash
    end
    Client.new(config)
  end

  def self.configure(&block)
    yield self
  end

end
