module Rbsx
  class Client

    attr_accessor(*Rbsx::CONFIG_ATTRS)

    def initialize(config={})
      Rbsx::CONFIG_ATTRS.each do |attr|
        self.send :"#{attr}=", config[attr]
      end
    end

    def bci_fetch_last_height
      sx("bci-fetch-last-height").to_i
    end

    def generate_address(n)
      sx("echo #{master_public_key} | sx genaddr #{n}").chomp
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
