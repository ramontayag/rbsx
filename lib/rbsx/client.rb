module Rbsx
  class Client

    attr_accessor :sx_path

    def initialize(sx_path: sx_path)
      self.sx_path = sx_path
    end

    def bci_fetch_last_height
      sx("bci-fetch-last-height").to_i
    end

    def sx(command)
      full_command = [sx_path, command].join(" ")
      `#{full_command}`
    rescue Errno::ENOENT
      fail(
        SxNotFound, [
          "sx path `#{sx_path}` does not seem to exist.",
          "Please make sure that you can execute `#{full_command}`.",
        ].join(" ")
      )
    end

  end
end
