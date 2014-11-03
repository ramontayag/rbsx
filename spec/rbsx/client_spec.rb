require "spec_helper"

module Rbsx
  describe Client do

    describe "initialization" do
      Rbsx::CONFIG_ATTRS.each do |attr|
        it "accepts #{attr}" do
          client = described_class.new(attr => "localval")
          expect(client.send(attr)).to eq "localval"
        end
      end
    end

    describe "#sx" do
      it "executes the command with the sx_path" do
        client = described_class.new(sx_path: "/sx")
        expect(client).to receive(:`).with("/sx mycommand")
        client.sx "mycommand"
      end

      context "given the wrong sx path" do
        it "raises an error describing what might be wrong" do
          client = described_class.new(sx_path: "/nonexistent")
          expect { client.sx("help") }.to raise_error(
            SxNotFound,
            [
              "sx path `/nonexistent` does not seem to exist.",
              "Please make sure that you can execute `/nonexistent help`.",
            ].join(" ")
          )
        end
      end
    end

    describe "#bci_fetch_last_height" do
      it "returns the result of `bci-fetch-last-height`" do
        client = described_class.new
        allow(client).to receive(:sx).with("bci-fetch-last-height").
          and_return("12387237")
        expect(client.bci_fetch_last_height).to eq 12387237
      end
    end

    describe "#generate_address" do
      it "generates an address based on the master public key" do
        client = described_class.new(CONFIG.slice(:master_public_key))
        expect(client.generate_address(0)).to eq CONFIG[:address_0]
      end
    end

  end
end
