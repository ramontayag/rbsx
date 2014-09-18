require "active_support/core_ext/module/attribute_accessors"
require "active_support/core_ext/hash/indifferent_access"
require "rbsx/version"
require "rbsx/client"
require "rbsx/exceptions"

module Rbsx

  mattr_accessor :sx_path

  def self.new
    Client.new(sx_path: self.sx_path)
  end

  def self.configure(&block)
    yield self
  end

end
