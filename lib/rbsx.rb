require "active_support/core_ext/module/attribute_accessors"
require "active_support/core_ext/hash/indifferent_access"
require "rbsx/version"
require "rbsx/client"
require "rbsx/exceptions"

module Rbsx

  mattr_accessor :sx_path

  def self.new(sx_path: Rbsx.sx_path)
    Client.new(sx_path: sx_path)
  end

  def self.configure(&block)
    yield self
  end

end
