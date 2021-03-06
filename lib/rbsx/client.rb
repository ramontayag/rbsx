module Rbsx
  class Client

    attr_accessor(*Rbsx::CONFIG_ATTRS)

    def initialize(config={})
      Rbsx::CONFIG_ATTRS.each do |attr|
        self.send :"#{attr}=", config[attr] || Rbsx.send(attr)
      end
    end

    def bci_fetch_last_height
      sx("sx bci-fetch-last-height").to_i
    end

    def address(n)
      key = if public_key == "" || public_key == nil
              private_key
            else
              public_key
            end
      sx("echo #{key} | sx addr #{n}").chomp
    end

    def valid_address?(address)
      sx("sx validaddr #{address}").include?("Success")
    end

    def new_private_key
      sx("sx privkey")
    end

    def sx(command)
      full_command = command.gsub(/sx/, sx_path)
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
